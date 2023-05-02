//
//  TaskItem+CoreDataProperties.swift
//  ios
//
//  Created by Ismail Tever on 1.05.2023.
//
//

import Foundation
import CoreData


extension TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem")
    }

    @NSManaged public var task: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var color: String?

}

extension TaskItem : Identifiable {

}
