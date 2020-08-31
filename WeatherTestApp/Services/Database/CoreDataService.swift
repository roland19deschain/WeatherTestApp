//
//  CoreDataService.swift
//  WeatherTestApp
//
//  Created by User on 8/31/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataService<MappedObject: MappedObjectProtocol>: DatabaseServiceProtocol where MappedObject.Object: ObjectProtocol {
    func fetch(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]) -> [MappedObject] {
        let request = NSFetchRequest<MappedObject.Object>(entityName: String(describing: MappedObject.Object.self))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        do {
            let objects = try context.fetch(request)
            return objects.compactMap { $0.toMappedObject() }
        } catch {
            fatalError()
        }
    }
    
    func save(mappedObject: MappedObject) {
        let object = mappedObject.toObject(context: context)
        context.insert(object)
        saveContext()
    }
    
    func delete(by identifier: String) {
        guard let url = URL(string: identifier), let id = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: url) else { return }
        let object = context.object(with: id)
        context.delete(object)
        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
    
}
