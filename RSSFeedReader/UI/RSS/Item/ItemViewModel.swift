//
//  ItemViewModel.swift
//  RSSFeedReader
//
//  Created by Munara on 5/7/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation

class ItemViewModel {
    
    private let item: RSSItem
    
    init(item: RSSItem) {
        self.item = item
    }
    
    func getDescription() -> String {
        return item.description
    }
    func getTitle() -> String {
        return item.title
    }
}
