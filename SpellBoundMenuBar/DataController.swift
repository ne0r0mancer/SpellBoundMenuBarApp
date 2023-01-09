//
// Created by ne0r0mancer on 1/9/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "SpellBound")
    init() {
        container.loadPersistentStores { description, error in
            print("Core Data: \(description)")
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    func saveContext () {
        print("saveContext")
        print("Currrent context: \(container.viewContext)")
        let context = container.viewContext
        if context.hasChanges {
            do {
                print("Saving context")
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
