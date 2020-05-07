//
//  PersistenceService.swift
//  RSSFeedReader
//
//  Created by Munara on 5/6/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService {
    
    private init() {
        
    }
    static let shared = PersistenceService()
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
    
       let container = NSPersistentContainer(name: "RSSFeedReader")
       container.loadPersistentStores(completionHandler: { (storeDescription, error) in
           if let error = error as NSError? {
              
               fatalError("Unresolved error \(error), \(error.userInfo)")
           }
       })
       return container
   }()
    
    func save (completion: @escaping() -> Void) {
       let context = persistentContainer.viewContext
       if context.hasChanges {
           do {
               try context.save()
                completion()
           } catch {
               let nserror = error as NSError
               fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
           }
       }
   }
    
    func fetch<T: NSManagedObject>(type: T.Type, completion: @escaping([T]) -> Void) {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        do {
            let object = try context.fetch(request)
            completion(object)
        } catch {
            print(error)
            completion([])
        }
    }
    
  
}
