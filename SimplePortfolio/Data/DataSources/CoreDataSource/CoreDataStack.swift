//
//  CoreDataStack.swift
//  SimplePortfolio
//
//  Created by Ivan Vrkic on 20.06.2021..
//

import CoreData

class CoreDataStack {

    private let modelName: String

    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()

    init(modelName: String) {
        self.modelName = modelName
    }

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores() { storeDescription, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func saveContext () {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }

}
