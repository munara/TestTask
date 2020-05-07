//
//  RSSCoordinator.swift
//  RSSFeedReader
//
//  Created by Munara on 5/6/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import UIKit

class RSSCoordinator {
    
    private (set) var rootNavigation: UINavigationController?
    private var rssViewController: RSSViewController?
    private let dataStore: RSSDataStore
    init() {
        dataStore = RSSDataStore()
    }
    
    func initialize() -> UIViewController? {
        let navigationController = UIStoryboard(name: "RSSController", bundle: nil).instantiateInitialViewController() as? UINavigationController
        rootNavigation = navigationController
        rssViewController = navigationController?.viewControllers.first as? RSSViewController
        let viewModel = RSSViewModel(dataStore: dataStore)
        viewModel.actionDelegate = self
        viewModel.displayDelegate = rssViewController
        self.rssViewController?.viewModel = viewModel
        return navigationController
    }
}
extension RSSCoordinator: RSSActionDelegate {
    func showItems(of feed: Feed) {
        guard let feedController = UIStoryboard(name: "FeedController", bundle: nil).instantiateInitialViewController() as? FeedViewController else {
            return
        }
        let viewModel = FeedViewModel(dataStore: dataStore, feed: feed)
        viewModel.displayDelegate = feedController
        viewModel.actionDelegate = self
        feedController.viewModel = viewModel
        rootNavigation?.pushViewController(feedController, animated: true)
    }
}
extension RSSCoordinator: FeedActionDelegate {
    func showDescription(of item: RSSItem) {
        guard let itemController = UIStoryboard(name: "ItemController", bundle: nil).instantiateInitialViewController() as? ItemViewController else {
            return
        }
        itemController.viewModel = ItemViewModel(item: item)
        rootNavigation?.pushViewController(itemController, animated: true)
    }
    
    
}
