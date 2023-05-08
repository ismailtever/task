//
//  ViewController.swift
//  ios
//
//  Created by Ismail Tever on 27.04.2023.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    //MARK: - UI Elements
    @IBOutlet var tableView: UITableView!
    var searchController:UISearchController!
    
    //MARK: - Properties
    private let parameters : [String : Any] = [
        "username": "365",
        "password": "1"
    ]
    private var coreDataItems = [TaskItem]()
    private var searchArray:[TaskItem] = []
    private let managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        setupPullRefresh()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataItems()
    }
    
    //MARK: - Functions
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
    }
    private func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Tasks..."
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.blue
    }
    private func setupPullRefresh() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    @objc func didPullToRefresh(sender: AnyObject) {
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
        DispatchQueue.main.async {
            self.fetchCoreDataItems()
            self.tableView.refreshControl?.endRefreshing()

        }
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
        if searchController.isActive == true {
                    return searchArray.count
                } else {
                    return coreDataItems.count
            }
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
//                let taskData = coreDataItems[indexPath.row]
                let items = (searchController.isActive) ? searchArray[(indexPath as NSIndexPath).row] : coreDataItems[(indexPath as NSIndexPath).row]
                let color1 = (UIColor(hexString: items.value(forKey: "color") as! String))
                cell.taskLabel.text = items.value(forKey: "task") as? String
                cell.titleLabel.text = items.value(forKey: "title") as? String
                cell.descriptionLabel.text = items.value(forKey: "desc") as? String
                cell.coloredCircle.tintColor = color1
            } catch {
                print(error)
            }
        }
        return cell
    }
}
extension ViewController: UISearchResultsUpdating {
    func filterContentForSearchText(_ searchText: String) {
            searchArray = coreDataItems.filter({ (coreDataItems:TaskItem) -> Bool in
                let taskMatch = coreDataItems.task!.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                let titleMatch = coreDataItems.title!.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                let descriptionMatch = coreDataItems.description.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return taskMatch != nil || titleMatch != nil || descriptionMatch != nil}
            )
        }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
}
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

