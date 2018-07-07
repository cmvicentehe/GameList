//
//  GameListVC.swift
//  GameList
//
//  Created by Carlos Manuel Vicente Herrero on 7/7/18.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import UIKit

protocol GameListUI: class {
    var presenter: GameListPresenter? { get set }
    
    func displayActivityIndicator()
    func hideActivityIndicator()
    func show(error message: String)
    func gamesReceived()
}

class GameListVC: UIViewController {
    // MARK: Properties
    var presenter: GameListPresenter?
    
    // MARK: Outlets
    @IBOutlet weak var gameList: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Statics
    static let cellIdentifier: String = "GameCell"
    
    // MARK: Life - Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Game List"
        self.presenter?.viewDidLoaded()
    }
}

extension GameListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.games.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameListVC.cellIdentifier, for: indexPath) as? GameCell else {
            return GameCell(style: .default, reuseIdentifier: GameListVC.cellIdentifier)
        }
        
        if let game = self.presenter?.games[indexPath.row] {
            cell.configureCell(with: game)
        }
        
        return cell
    }
}

extension GameListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension GameListVC: GameListUI {
    func show(error message: String) {
        print("Error received: \(message)")
        
    }
    
    func gamesReceived() {
        DispatchQueue.main.async {
            self.gameList.reloadData()
        }
    }
    
    func displayActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
}
