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
}

class GameListVC: UIViewController {
    // MARK: Properties
    var presenter: GameListPresenter?
    
    // MARK: Outlets
    @IBOutlet weak var gameList: UITableView!
    
    // MARK: Life - Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension GameListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 // TODO: Implement!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: "GameCell") // TODO: Implement!
    }
}

extension GameListVC: GameListUI {}
