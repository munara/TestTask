//
//  ViewModel.swift
//  RSSFeedReader
//
//  Created by Munara on 5/5/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation

protocol  RSSActionDelegate: class {
    func showItems(of feed: Feed)
}

protocol RSSDisplayDelegate: class {
    func updateTableView()
     func deleteTableViewRow(with indexPath: IndexPath)
}

class RSSViewModel {
    var feeds: [Feed]?
    weak var actionDelegate: RSSActionDelegate?
    weak var displayDelegate: RSSDisplayDelegate?
    
    private let dataStore: RSSDataStore
    
    init(dataStore: RSSDataStore) {
        self.dataStore = dataStore
    }
    
    func getFeedsCount() -> Int? {
        return feeds?.count
    }
    
    func getFeed(with index: Int) -> String? {
        return feeds?[index].wrappedTitle
    }
    
    func showFeed(with index: Int) {
        guard let feed = feeds?[index] else {
            return
        }
        actionDelegate?.showItems(of: feed)
    }
    
    func addFeed(name: String, link: String) {
        if feeds?.contains(where: { $0.title == name }) ?? false {
            return
        }
        dataStore.saveFeed(name: name, link: link) { [weak self] result in
            self?.feeds = result
            self?.displayDelegate?.updateTableView()
        }
    }
    
    func fetchFeeds() {
        dataStore.fetchFeeds {[weak self] result in
            self?.feeds = result
            DispatchQueue.main.async {
                self?.displayDelegate?.updateTableView()
            }
        }
    }
    func deleteFeed(with indexPath: IndexPath) {
        guard let feed = feeds?[indexPath.row] else {
            return
        }
        dataStore.deleteFeed(feed: feed) {
            self.feeds?.remove(at: indexPath.row)
            DispatchQueue.main.async {
                self.displayDelegate?.deleteTableViewRow(with: indexPath)
            }
        }
    }
}
