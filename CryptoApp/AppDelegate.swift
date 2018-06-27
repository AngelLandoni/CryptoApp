//
//  AppDelegate.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
        ) -> Bool {
        // Create a new window.
        window = UIWindow()
        window?.makeKeyAndVisible()
        // Alloc main controllers.
        let list: UINavigationController = UINavigationController(
            rootViewController: CryptoListModule.generateCryptoList())
        // Alloc the tab bar.
        let tabBar: UITabBarController = UITabBarController()
        tabBar.viewControllers = [
            list,
            CryptoPortfolioModule.generateCryptoPortfolio(),
        ]
        // Set the tab bar.
        window?.rootViewController = tabBar
        return true
    }
}

