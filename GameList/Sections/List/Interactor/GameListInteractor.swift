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
    // TODO: Implement outoput methos
}

struct GameListInteractor {
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
        // TODO: Implement using Codable and decodable methods instead
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable: Any] else  {
            print("Invalid JSON")
            return nil
        }
        
        guard let gamesDict: [AnyHashable: Any] = json?["games"] as? [AnyHashable : Any] else {
            print("Error parsing dictionary")
            return nil
        }
        let gameKeys = gamesDict.keys
        
        var gamesListDict: [[AnyHashable: Any]] = [[AnyHashable: Any]]()
        
        gameKeys.forEach { key in
            if  let gameDictReceived = gamesDict[key] as? [AnyHashable : Any] {
                gamesListDict.append(gameDictReceived )
            }
        }
        
        var games: [Game] = [Game]()
        
        gamesListDict.forEach { gameDict in
            let id: String = gameDict["gameId"] as? String ?? ""
            let name: String = gameDict["name"] as? String ?? ""
            let playUrl: String? = gameDict["playUrl"] as? String
            let launchLocale: String? = gameDict["launchLocale"] as? String
            let imageUrl: String = gameDict["imageUrl"] as? String ?? ""
            let backgroundImageUrl: String? = gameDict["backgroundImageUrl"] as? String ?? ""
            let tags: [String]? = gameDict["tags"] as? [String]
            let vendorId: String? = gameDict["vendorId"] as? String
            
            let game = Game(id: id,
                            name: name,
                            playUrl: playUrl,
                            launchLocale: launchLocale,
                            imageUrl: imageUrl,
                            backgroundImageUrl: backgroundImageUrl,
                            tags: tags,
                            vendorId: vendorId)
            games.append(game)
        }
        print("\(games)")
        return games
    }
}

extension GameListInteractor: GameListInteractorInput {
    func fetchGames() {
        let networkClient = NetworkClient()
        guard let request = self.buildUrlRequest() else {
            print("Invalid url request")
            return
        }
        
        networkClient.performRequest(for: request) { response in
            guard let data = response?.data else {
                if let error =  response?.error {
                    print("There was an error \(error)")
                    // TODO: Notify Error to presenter and view
                }
                return
            }
            let games = self.parse(data)
        }
    }
    
}
