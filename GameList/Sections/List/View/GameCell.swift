//
//  GameCell.swift
//  GameList
//
//  Created by Carlos Manuel Vicente Herrero on 7/7/18.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameIdentifier: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.gameImage.image = nil
    }
    
    func configureCell(with game: Game) {
        self.gameImage.backgroundColor = UIColor.blue
        self.gameName.text = game.name
        self.gameIdentifier.text = game.id
    }
    
    func set(image: UIImage) {
        self.gameImage.image = image
    }
}
