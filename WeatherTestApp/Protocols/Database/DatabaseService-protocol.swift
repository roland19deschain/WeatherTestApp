//
//  DatabaseService-protocol.swift
//  WeatherTestApp
//
//  Created by User on 8/31/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit
import CoreData

// TODO: - Catch controller error
protocol DatabaseServiceProtocol {
    associatedtype MappedObject: MappedObjectProtocol
    
    func fetch(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]) -> [MappedObject]
    func save(mappedObject: MappedObject)
    func delete(by identifier: String)
}

extension DatabaseServiceProtocol where MappedObject.Object: NSManagedObject {
    var container: NSPersistentContainer {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func controller(predicate: NSPredicate?,
                    sortDescriptors: [NSSortDescriptor],
                    sectionName: String?,
                    cacheName: String?) -> NSFetchedResultsController<MappedObject.Object>
    {
        let request = NSFetchRequest<MappedObject.Object>(entityName: String(describing: MappedObject.Object.self))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: sectionName, cacheName: cacheName)
        
        do {
            try controller.performFetch()
        } catch {
            fatalError()
        }
        
        return controller
    }
}
