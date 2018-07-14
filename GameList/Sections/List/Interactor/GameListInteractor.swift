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
}

protocol GameListInteractorOutput {
    func gamesReceived(_ games: [Game])
    func errorReceived(_ error: String)
}

class GameListInteractor {
    var presenter: GameListInteractorOutput?
    
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
    
}
