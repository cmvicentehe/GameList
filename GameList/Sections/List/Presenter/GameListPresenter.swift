//
//  GameListPresenter.swift
//  GameList
//
//  Created by Carlos Manuel Vicente Herrero on 7/7/18.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

protocol GameListPresenterInput {
    var view: GameListUI? { get set }
    var interactor: GameListInteractorInput? { get set }
    
    func viewDidLoaded()
    func viewDidReciveMemoryWarning()
    func cell(for game: Game, completion: @escaping(Data) -> Void)
}

class GameListPresenter {
    var view: GameListUI?
    var interactor: GameListInteractorInput?
    var games: [Game]
    
    convenience init() {
        let games = [Game]()
        self.init(games: games)
    }
    
    init(games: [Game]) {
        self.games = games
    }
}

extension GameListPresenter: GameListPresenterInput {
    func viewDidLoaded() {
        self.view?.displayActivityIndicator()
        self.interactor?.fetchGames()
    }
    
    func viewDidReciveMemoryWarning() {
        self.interactor?.clearImageCache()
    }
    
    func cell(for game: Game, completion: @escaping(Data) -> Void) {
        self.interactor?.fetchImage(from: game, completion: completion)
    }
}

extension GameListPresenter: GameListInteractorOutput {
    func gamesReceived(_ games: [Game]) {
        self.games = games
        self.view?.hideActivityIndicator()
        self.view?.gamesReceived()
    }
    
    func errorReceived(_ error: String) {
        self.view?.show(error: error)
    }
}
