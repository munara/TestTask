//
//  AppDelegate.swift
//  RSSFeedReader
//
//  Created by Munara on 5/5/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootCoordinator: RootCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.rootCoordinator = RootCoordinator()
        self.window?.rootViewController = self.rootCoordinator?.initialize()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

