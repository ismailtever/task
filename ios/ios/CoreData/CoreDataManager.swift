//
//  CoreDataYeni.swift
//  ios
//
//  Created by Ismail Tever on 4.05.2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    //MARK: - Properties
    static let shared = CoreDataManager()
    private var coreDataItems = [TaskItem]()
    
    //MARK: - Functions
    func saveToCoreData(tasks: [Task]) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedObjectContext = appDelegate?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "TaskItem", in: managedObjectContext!)
        
        for task in tasks {
            let taskItem = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
            taskItem.setValue(task.task, forKey: "task")
            taskItem.setValue(task.title, forKey: "title")
            taskItem.setValue(task.description, forKey: "desc")
            taskItem.setValue(task.colorCode, forKey: "color")
        }
        try! managedObjectContext?.save()
    }
    
    
//    func fetchCoreDataItems() {
//        let managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<TaskItem>(entityName: "TaskItem")
//        coreDataItems = try! managedObjectContext!.fetch(fetchRequest)
//    }
    
    func fetchFromCoreData() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedObjectContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TaskItem>(entityName: "TaskItem")
        
        coreDataItems = try! managedObjectContext!.fetch(fetchRequest)
    }
    func printCoreData(context: NSManagedObjectContext) {
        do {
            let result = try context.fetch(NSFetchRequest<TaskItem>(entityName: "TaskItem"))
            for data in result as [NSManagedObject] {
                print(data.value(forKey: "task") as! String)
                print(data.value(forKey: "title") as! String)
                print(data.value(forKey: "desc") as! String)
                print(data.value(forKey: "color") as! String)
            }
        } catch {
            print("Failed")
        }
    }
    func deleteObjectsFromCoreData(context: NSManagedObjectContext) {
        do {
            let fetchRequest = NSFetchRequest<TaskItem>(entityName: "TaskItem")
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
}
