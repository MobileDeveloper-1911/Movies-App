//
//  PersistentStorage.swift
//  Movies
//
//  Created by Vaibhav Gawde on 16/06/24.
//

import Foundation
import CoreData

final class PersistentStorage {
    
    private init(){}
    
    static let Shared = PersistentStorage()
    
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
      
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
             
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var  context = persistentContainer.viewContext

    
    //MARK: - Core Data Saving Support
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
   
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
