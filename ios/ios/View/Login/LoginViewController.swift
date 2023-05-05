//
//  LoginViewController.swift
//  ios
//
//  Created by Ismail Tever on 5.05.2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButton(_ sender: Any) {
        if userNameTextField.text == "365" && passwordTextField.text == "1" {
            activityIndicatorView.startAnimating()

        }
    }
    
}
