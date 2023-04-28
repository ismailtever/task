//
//  Network.swift
//  ios
//
//  Created by Ismail Tever on 27.04.2023.
//

import Foundation
import Alamofire

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum ErrorTypes: String, Error{
    case invalidData = "Invalid Data"
    case invalidURL = "Invalid URL"
    case generalError = "An error happened"
}


struct NetworkHelper {
    static let shared = NetworkHelper()
    
    let baseURL = "https://api.baubuddy.de/index.php/login"
    
    func header() -> HTTPHeaders {
        [
            "Authorization": "Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz",
            "Content-Type": "application/json"
        ]
    }

    
    func saveToken(token: String) {
        
    }
}










