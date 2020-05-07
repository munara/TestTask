//
//  RootCoordinator.swift
//  RSSFeedReader
//
//  Created by Munara on 5/6/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import UIKit

class RootCoordinator {
    
    private var tabBarController: UITabBarController
    private var rssCoordinator: RSSCoordinator
    private var weatherCoordinator: WeatherCoordinator
    
    init() {
         tabBarController = UITabBarController()
        rssCoordinator = RSSCoordinator()
        weatherCoordinator = WeatherCoordinator()
    }
    
    func initialize() -> UIViewController? {
        if let rssController = rssCoordinator.initialize(),
            let weatherController = weatherCoordinator.initialize() {
            tabBarController.viewControllers = [rssController,
                                               weatherController]
        }
        return tabBarController
    }
}
