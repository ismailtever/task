//
//  CoreDataManager.swift
//  ios
//
//  Created by Ismail Tever on 2.05.2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private let fetchRequest = NSFetchRequest<TaskItem>(entityName: "TaskItem")
    
    func saveDataOf(tasks: [Task]) {
        
        // Updates coredata with the new data from the server - Off the main thread.
        self.container?.performBackgroundTask { [weak self] context in
            self?.deleteObjectsFromCoreData(context: context)
            self?.saveDataToCoreData(tasks: tasks, context: context)
        }
    }
    
    //MARK: - Delete Core Data objects before saving new data
    private func deleteObjectsFromCoreData(context: NSManagedObjectContext) {
        do {
            // Fetch Data
            let objects = try context.fetch(fetchRequest)
            
            // Delete Data
            _ = objects.map({context.delete($0)})
            
            // Save Data
            try context.save()
        } catch {
            print("Deleting error: \(error)")
        }
    }
    
    //MARK: - Save new data from the server to the Core Data
    private func saveDataToCoreData(tasks: [Task], context: NSManagedObjectContext) {
        // perfrom - Make sure this code block will be executed on the proper Queu.
        // In this case this code should be perform off the main Queue.
        context.perform {
            print("Are we on the main Queu?: \(String(describing: Thread.isMainThread))")
            
            for task in tasks {
                let taskItem = TaskItem(context: context)
                taskItem.task = task.task
                taskItem.title = task.title
                taskItem.desc = task.description
                taskItem.color = task.colorCode
            }
            // Save Data
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            // Print Core Data
            do {
                let result = try context.fetch(self.fetchRequest)
                for data in result as! [NSManagedObject] {
                    print(data.value(forKey: "task") as! String)
                    print(data.value(forKey: "title") as! String)
                    print(data.value(forKey: "desc") as! String)
                    print(data.value(forKey: "color") as! String)
                }
            } catch {
                print("Failed")
            }
        }
        
    }
    
}
