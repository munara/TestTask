//
//  City+CoreDataProperties.swift
//  RSSFeedReader
//
//  Created by Munara on 5/8/20.
//  Copyright © 2020 Munara. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    public var wrappedName: String {
        name ?? "Unknown name"
    }
}
