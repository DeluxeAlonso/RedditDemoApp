//
//  VisitedPost.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import CoreData

final class VisitedPost: NSManagedObject {

    @NSManaged fileprivate(set) var id: String

    static func insert(into context: NSManagedObjectContext, id: String) -> VisitedPost {
        let visitedPost: VisitedPost = context.insertObject()
        visitedPost.id = id
        return visitedPost
    }

}

extension VisitedPost: Managed {

    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(id), ascending: true)]
    }

}

extension NSManagedObjectContext {

    func insertObject<A: NSManagedObject>() -> A where A: Managed {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else {
            fatalError("Wrong object type")
        }
        return obj
    }

    func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }

    func performChanges(block: @escaping () -> Void) {
        perform {
            block()
            _ = self.saveOrRollback()
        }
    }

}
