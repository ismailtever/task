////
////  TaskViewModel.swift
////  ios
////
////  Created by Ismail Tever on 3.05.2023.
////
//
//import Foundation
//
//struct TaskTableViewModel {
//
//    let taskList: [Task]
//
//    func numberOfRowsInSection() -> Int {
//        return self.taskList.count
//    }
//
//    func taskAtIndexPath(_ index: Int) -> TaskViewModel {
//        let task = self.taskList[index]
//        return TaskViewModel(tasks: task)
//    }
//}
//
//
//struct TaskViewModel {
//
//    let tasks : Task
//
//    var task : String {
//        return self.tasks.task ?? "error"
//    }
//    var title : String {
//        return self.tasks.title ?? "error"
//    }
//    var description : String {
//        return self.tasks.description ?? "error"
//    }
//    var color : String {
//        return self.tasks.colorCode ?? "error"
//    }
//}
