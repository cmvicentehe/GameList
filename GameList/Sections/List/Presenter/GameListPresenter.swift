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
}

struct GameListPresenter {
    var view: GameListUI?
    var interactor: GameListInteractorInput?
}

extension GameListPresenter: GameListPresenterInput {
    func viewDidLoaded() {
        self.interactor?.fetchGames()
    }
}

extension GameListPresenter: GameListInteractorOutput {
    
}
