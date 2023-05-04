//
//  ViewController.swift
//  ios
//
//  Created by Ismail Tever on 27.04.2023.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Properties
    private let parameters : [String : Any] = [
        "username": "365",
        "password": "1"
    ]
    private var coreDataItems = [TaskItem]()
    private let managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        CoreDataManager.shared.deleteObjectsFromCoreData(context: managedObjectContext!)
        AuthService.shared.login(parameters: parameters) { Response in
            TaskService.shared.getUserTasks { res in
                print(res)
                print("-------------------------")
                CoreDataManager.shared.saveToCoreData(tasks: res)
                self.fetchCoreDataItems()
                print("-------------------------")
            } failure: { ErrorMessage in
                print(ErrorMessage)
            }
        } failure: { ErrorMessage in
            print(ErrorMessage)
        }
//        CoreDataManager.shared.printCoreData(context: managedObjectContext!)
    }
    
    //MARK: - Functions
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func fetchCoreDataItems() {
        let fetchRequest = NSFetchRequest<TaskItem>(entityName: "TaskItem")
        coreDataItems = try! managedObjectContext!.fetch(fetchRequest)
        tableView.reloadData()
    }
}
// MARK: - Extensions
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataItems.count
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped.")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell
        
        if coreDataItems.count > 0 {
            do {
                let taskData = coreDataItems[indexPath.row]
                cell.taskLabel.text = taskData.value(forKey: "task") as? String
                cell.titleLabel.text = taskData.value(forKey: "title") as? String
                cell.descriptionLabel.text = taskData.value(forKey: "desc") as? String
                cell.colorLabel.text = taskData.value(forKey: "color") as? String
            } catch {
                print(error)
            }
        }
        return cell
    }
}

