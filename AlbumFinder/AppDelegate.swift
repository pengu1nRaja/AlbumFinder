//
//  AppDelegate.swift
//  AlbumFinder
//
//  Created by PenguinRaja on 18.09.2021.
//

import UIKit

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let tabBar = UITabBarController()
        let layout = UICollectionViewFlowLayout()
        let albumVC = AlbumViewController(collectionViewLayout: layout)
        let navBar = UINavigationController(rootViewController: albumVC)
        
        tabBar.viewControllers = [navBar, HistoryViewController()]
        
        tabBar.viewControllers?.first?.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        tabBar.viewControllers?.first?.tabBarItem.title = "Search"
        tabBar.viewControllers?.last?.tabBarItem.image = UIImage(systemName: "clock.arrow.circlepath")
        tabBar.viewControllers?.last?.tabBarItem.title = "History"
        
        window?.rootViewController = tabBar
        return true
    }
}

