//
//  Persistence.swift
//  Fergie
//
//  Created by Marshall Kurniawan on 20/06/22.
//

import Foundation
import CoreData

struct PersistenceController{
    static let shared = PersistenceController()
    
    let container:NSPersistentContainer
    init(inMemory: Bool = false){
//        container = NSPersistentCloudKitContainer(name: "Fergie")
//        let description = container.persistentStoreDescriptions.first
//
//        description?.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.shrall.Fergie") // HERE !
//
//        container.loadPersistentStores(completionHandler: { (_, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
        let storeURL = AppGroup.facts.containerURL.appendingPathComponent("Fergie.xcdatamodeld")
        let description = NSPersistentStoreDescription(url: storeURL)
        description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.shrall.Fergie")

        container = NSPersistentCloudKitContainer(name: "Fergie")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        )
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
