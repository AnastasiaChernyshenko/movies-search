//
//  AppDelegate.swift
//  Movies_App
//
//  Created by Anastasia on 13.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    private var appCoordinator: Coordinator!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      let navController = UINavigationController()
      appCoordinator = AppCoordinator(router: Router(with: navController))
      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = navController
      window?.makeKeyAndVisible()
      
      appCoordinator.start()
      
      return true
    }

}

