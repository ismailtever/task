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
    
    
    @IBOutlet weak var loginButton: UIButton!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Functions
    @IBAction func loginButton(_ sender: Any) {
        let parameters : [String:Any] = ["username":userNameTextField.text!, "password":passwordTextField.text!]
        loginButton.isEnabled = false
        self.activityIndicatorView.startAnimating()
        AuthService.shared.login(parameters: parameters) { res in
            self.performSegue(withIdentifier: "toTasksPage", sender: nil)
            self.loginButton.isEnabled = true
            self.activityIndicatorView.stopAnimating()
        } failure: { error in
            self.loginButton.isEnabled = true
            self.activityIndicatorView.stopAnimating()
            self.showAlert()
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
