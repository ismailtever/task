//
//  NetworkUtility.swift
//  ios
//
//  Created by Ismail Tever on 1.05.2023.
//

import Foundation
import Alamofire

fileprivate let BASIC_AUTH_TOKEN = "QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz"

enum Api: String {
    case baseUrl = "https://api.baubuddy.de/index.php/"
}

enum TokenType: String {
    case bearer = "Bearer"
    case basic = "Basic"
}

struct Header {
    static let shared = Header()
    
    func header(tokenType:TokenType) -> HTTPHeaders {
        
        if(tokenType==TokenType.bearer){
            let accessToken = UserDefaults.standard.string( forKey: "accessToken")
            return [
                "Authorization": "Bearer \(String(describing: accessToken))",
            ]
        }else{
            return [
                "Authorization": "Basic \(BASIC_AUTH_TOKEN)",
            ]
        }
    }
}

enum NetworkResponse<T> {
    case success(T)
    case messageFailure(ErrorMessage)
}

enum Endpoint: String {
    case login = "login"
    case tasks = "v1/tasks/select"
}

enum Request {
    case login
    case tasks
    
    var path: String {
        switch self {
        case .login:
            return requestUrl(url: Endpoint.login.rawValue)
        case .tasks:
            return requestUrl(url: Endpoint.tasks.rawValue)
        }
    }
    
    func requestUrl(url: String) -> String {
        return Api.baseUrl.rawValue + url
    }
}

extension Data {
    func decode<T: Decodable>() throws -> T {
        return (try! JSONDecoder().decode(T.self, from: self))
    }
}
