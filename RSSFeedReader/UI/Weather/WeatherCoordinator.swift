//
//  WeatherCoordinator.swift
//  RSSFeedReader
//
//  Created by Munara on 5/6/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import UIKit

class WeatherCoordinator {
    private (set) var rootNavigation: UINavigationController?
    private var weatherViewController: WeatherViewController?
    private let dataStore: WeatherDataStore
    
    init() {
        dataStore = WeatherDataStore()
    }
    
    func initialize() -> UIViewController? {
        let navigationController = UIStoryboard(name: "WeatherController",bundle: nil).instantiateInitialViewController() as? UINavigationController
        rootNavigation = navigationController
        weatherViewController = navigationController?.viewControllers.first as? WeatherViewController
        let viewModel = WeatherViewModel(dataStore: dataStore)
        viewModel.displayDelegate = weatherViewController
        viewModel.actionDelegate = self
        weatherViewController?.viewModel = viewModel
        return navigationController
    }
}
extension WeatherCoordinator: WeatherActionDelegate {
    func showDescription(city: City) {
        guard let itemController = UIStoryboard(name: "CityController", bundle: nil).instantiateInitialViewController() as? CityViewController else {
            return
        }
        let viewModel = CityViewModel(dataStore: dataStore, city: city)
        viewModel.displayDelegate = itemController
        itemController.viewModel = viewModel
        rootNavigation?.pushViewController(itemController, animated: true)
    }
    
    
}
