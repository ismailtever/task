//
//  ViewController.swift
//  ios
//
//  Created by Ismail Tever on 27.04.2023.
//

import UIKit
import Alamofire
import CoreData
class ViewController: UIViewController {
    
    let parameters : [String : Any] = [
        "username": "365",
        "password": "1"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        AuthService.shared.login(parameters: parameters) { Response in
            TaskService.shared.getUserTasks { res in
                print(res)
                print("-------------------------")
                print("-------------------------")
                print("-------------------------")
                print(CoreDataManager.shared.saveDataOf(tasks: res))
            } failure: { ErrorMessage in
                print(ErrorMessage)
            }
        } failure: { ErrorMessage in
            print(ErrorMessage)
        }



    }
    
}
