//
//  LoginViewController.swift
//  ios
//
//  Created by Ismail Tever on 5.05.2023.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - UI Elements
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    //MARK: - Properties
    static let shared = LoginViewController()
        
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Functions
    @IBAction func loginButton(_ sender: Any) {
        if userNameTextField.text == "365" && passwordTextField.text == "1" {
            activityIndicatorView.startAnimating()
            performSegue(withIdentifier: "toTasksPage", sender: nil)
            activityIndicatorView.stopAnimating()
        } else {
            showAlert()
        }
    }
    func showAlert() {
        let alertController = UIAlertController(title: "ERROR!",
                                                message: "Username & Password wrong.",
                                                preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Okey",
                                                    style: UIAlertAction.Style.default,
                                                    handler: { _ in
                alertController.dismiss(animated: true)
            }))
        present(alertController, animated: true)
    }
}
