//
//  FeedViewModel.swift
//  RSSFeedReader
//
//  Created by Munara on 5/6/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation

protocol  FeedDisplayDelegate: class {
    func updateView()
}
protocol FeedActionDelegate: class {
    func showDescription(of item: RSSItem)
}
class FeedViewModel {
    
    private let feed: Feed
    private let dataStore: RSSDataStore
    private var items = [RSSItem]()
    weak var displayDelegate: FeedDisplayDelegate?
    weak var actionDelegate: FeedActionDelegate?
    init(dataStore: RSSDataStore, feed: Feed) {
        
        self.feed = feed
        self.dataStore = dataStore
    }
    
    func fetchItems() {
        dataStore.fetchItems(with: feed) { (items) in
            self.items = items
            DispatchQueue.main.async {
                self.displayDelegate?.updateView()
            }
        }
    }
    func getCount() -> Int {
        return items.count
    }
    func getItemCell(with index: Int) -> ItemCellViewModel? {
        return ItemCellViewModel(item: items[index])
    }
    func showItemDescription(with index: Int) {
        
        actionDelegate?.showDescription(of: items[index])
    }
}
