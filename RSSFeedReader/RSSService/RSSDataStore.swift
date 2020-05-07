//
//  DataStore.swift
//  RSSFeedReader
//
//  Created by Munara on 5/6/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import CoreData

class RSSDataStore: NSObject {
    
    let persistence = PersistenceService.shared
    
    override init() {
        super.init()
    }

    func saveFeed(name: String, link: String, completion: @escaping([Feed]) -> Void ) {
        
        let feed = Feed(context: self.persistence.context)
        feed.link = link
        feed.title = name
        
        DispatchQueue.main.async {
            self.persistence.save {
                self.persistence.fetch(type: Feed.self) { result in
                    completion(result)
                }
            }
        }
        
    }
    
    func fetchFeeds(completion: @escaping([Feed]) -> Void) {
        self.persistence.fetch(type: Feed.self) { result in
            completion(result)
        }
    }
    
    func fetchItems(with feed: Feed, completion: @escaping([RSSItem]) -> Void) {
        let itemsParser = ItemsParser()
        itemsParser.requestItems(feed.wrappedLink) { items in
           completion(items)
        }
    }
    func deleteFeed(feed: Feed, completion: @escaping() -> Void) {
        self.persistence.context.delete(feed)
        self.persistence.save {
            completion()
        }
    }
}

