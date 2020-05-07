//
//  Feed+CoreDataProperties.swift
//  RSSFeedReader
//
//  Created by Munara on 5/7/20.
//  Copyright © 2020 Munara. All rights reserved.
//
//

import Foundation
import CoreData


extension Feed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feed> {
        return NSFetchRequest<Feed>(entityName: "Feed")
    }

    @NSManaged public var link: String?
    @NSManaged public var title: String?
    public var wrappedTitle: String {
        title ?? "Unknown feed"
    }
    public var wrappedLink: String {
        link ?? "Unkown feed"
    }

}
