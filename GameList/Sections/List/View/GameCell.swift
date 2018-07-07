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
        
        // TODO: Remove this method and create an Image Downloader with cache system to avoid asking for the image continously if it has already been downloaded
        DispatchQueue.global(qos: .background).async() {
            guard let imageURL = URL(string: game.imageUrl) else {
                print("Invalid image url")
                return
            }
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                DispatchQueue.main.async {
                    guard let dataNotNil = data else {
                         print("Invalid data")
                        return
                    }
                    self.gameImage.image = UIImage(data: dataNotNil)
                }
                }.resume()
        }
    
    }
}
