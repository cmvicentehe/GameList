//
//  Game.swift
//  GameList
//
//  Created by Carlos Manuel Vicente Herrero on 7/7/18.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

struct Game: Codable {
    let id: String
    let name: String
    let playUrl: String?
    let launchLocale: String?
    let imageUrl: String
    let backgroundImageUrl: String?
    let tags: [String]?
    let vendorId: String?
}
