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
}

protocol GameListInteractorOutput {
}

struct GameListInteractor {
    var presenter: GameListInteractorOutput?
}

extension GameListInteractor: GameListInteractorInput {
    
}
