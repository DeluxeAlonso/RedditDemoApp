//
//  CoreDataStack.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import CoreData

public class CoreDataStack {

    public static let shared = CoreDataStack()

    private var persistentStoreDescriptions: [NSPersistentStoreDescription] = []

    // MARK: - CoreDataStackProtocol

    var mainContext: NSManagedObjectContext {
        let container = isTesting() ? mockPersistantContainer : persistentContainer
        let context = container.viewContext
        context.mergePolicy = NSMergePolicy.overwrite
        return context
    }

    func setExtensionPersistentStoreDescriptions(_ groupExtensionIds: [String]) {
        persistentStoreDescriptions = groupExtensionIds.map({ groupId in
            let storeURL = URL.storeURL(for: groupId, databaseName: Constants.containerName)
            let storeDescription = NSPersistentStoreDescription(url: storeURL)
            return storeDescription
        })
    }

    // MARK: - Private

    private lazy var persistentContainer: NSPersistentContainer = {
        let bundle = Bundle(for: CoreDataStack.self)
        guard let url = bundle.url(forResource: Constants.containerName, withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError()
        }

        let container = NSPersistentContainer(name: Constants.containerName, managedObjectModel: model)

        if !persistentStoreDescriptions.isEmpty {
            container.persistentStoreDescriptions = persistentStoreDescriptions
        }

        container.loadPersistentStores { _, error in
            guard error == nil else { fatalError() }
        }
        return container
    }()

    // MARK: - Test mockups

    private lazy var mockPersistantContainer: NSPersistentContainer = {
        let bundle = Bundle(for: CoreDataStack.self)
        guard let url = bundle.url(forResource: Constants.containerName, withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError()
        }

        let container = NSPersistentContainer(name: Constants.containerName, managedObjectModel: model)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in

            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )

            // Check if creating container wrong
            if let error = error {
                fatalError("In memory coordinator creation failed \(error)")
            }
        }
        return container
    }()

    private func isTesting() -> Bool {
        return NSClassFromString("XCTest") != nil
    }

}

// MARK: - Constants

extension CoreDataStack {

    struct Constants {
        static let containerName = "RedditDemoApp"
    }

}

extension URL {

    /// Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }

        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }

}
