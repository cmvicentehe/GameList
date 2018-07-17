//
//  GameListInteractor.swift
//  GameList
//
//  Created by Carlos Manuel Vicente Herrero on 7/7/18.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

protocol GameListInteractorInput {
    var presenter: GameListInteractorOutput? { get set }
    func fetchGames()
    func fetchImage(from game: Game, completion: @escaping (Data) -> Void)
    func clearImageCache()
}

protocol GameListInteractorOutput {
    func gamesReceived(_ games: [Game])
    func errorReceived(_ error: String)
}

class GameListInteractor {
    var presenter: GameListInteractorOutput?
    let imageDownloader: ImageDownloader
    
    init(imageDownloader: ImageDownloader) {
        self.imageDownloader = imageDownloader
    }
    
    fileprivate func buildUrlRequest() -> URLRequest? {
        guard let url = URL(string: Network.url) else {
            print("Invalid url")
            return nil
        }
        let request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 30)
        
        return request
    }
    
    fileprivate func parse(_ data: Data) -> [Game]? {
        var games: [Game]? = [Game]()
        do {
            let decoder = JSONDecoder()
            let gamesDictionary: GameDictionary = try decoder.decode(GameDictionary.self, from: data)
            let gameListDictionary = gamesDictionary.games
            gameListDictionary.keys.forEach { key in
                if let game = gameListDictionary[key] {
                    games?.append(game)
                }
            }
        } catch let error {
            print("Error received", error)
        }
        
        return games
    }
}

extension GameListInteractor: GameListInteractorInput {
    func fetchGames() {
        let networkClient = NetworkClient()
        guard let request = self.buildUrlRequest() else {
            print("Invalid url request")
            self.presenter?.errorReceived("Invalid url request")
            return
        }
        
        networkClient.performRequest(for: request) { response in
            guard let data = response?.data else {
                if let error =  response?.error {
                    print("There was an error \(error)")
                     self.presenter?.errorReceived(error.localizedDescription)
                }
                return
            }
            guard let games = self.parse(data) else {
                print("Invalid game list")
                self.presenter?.errorReceived("Invalid url request")
                return
            }
            self.presenter?.gamesReceived(games)
        }
    }
    
    func fetchImage(from game: Game, completion: @escaping (Data) -> Void) {
        let url = game.imageUrl
        guard let data = self.imageDownloader.loadCachedImage(from: url) else {
            print("Image \(url) NOT CACHED")
            self.imageDownloader.loadImage(from: url, completion: completion)
            return
        }
        print("Image \(url) CACHED")
        completion(data)
    }
    
    func clearImageCache() {
        self.imageDownloader.clearCache()
    }
}
