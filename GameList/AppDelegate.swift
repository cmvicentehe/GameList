//
//  AppDelegate.swift
//  GameList
//
//  Created by Carlos Manuel Vicente Herrero on 7/7/18.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Properties
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.initializeWindow()
        return true
    }
    
     // MARK: Private methods
    fileprivate func initializeWindow() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        if let gameListVC: GameListVC = storyboard.instantiateViewController(withIdentifier: "GameListVC") as? GameListVC {
            let gameListPresenter = GameListPresenter()
            let cache = NSCache<NSString, NSData>()
            let imageDownloader = ImageDownloaderImpl(cache: cache)
            let gameListInteractor = GameListInteractor(imageDownloader: imageDownloader)
            gameListPresenter.view = gameListVC
            gameListPresenter.interactor = gameListInteractor
            gameListInteractor.presenter = gameListPresenter
            gameListVC.presenter = gameListPresenter
            let navigationController = UINavigationController(rootViewController: gameListVC)
            window?.rootViewController = navigationController
        }
        window?.makeKeyAndVisible()
    }
}

