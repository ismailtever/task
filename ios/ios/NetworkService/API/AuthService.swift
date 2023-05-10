//
//  Auth.swift
//  ios
//
//  Created by Ismail Tever on 1.05.2023.
//

import Foundation


class AuthService {
    static let shared = AuthService()

    func login(parameters:[String:Any],success: @escaping(Response)->(), failure: @escaping(ErrorMessage)->()) {
        NetworkManager.shared.request(type: Response.self, url: Request.login.path, headers: Header.shared.header(tokenType: TokenType.basic), params: parameters, method: .post) { response in
            switch response {
            case .success(let authInfo):
                UserDefaults.standard.set(authInfo.oauth?.accessToken, forKey: "accessToken")
                success(authInfo)
                print(authInfo)
            case .messageFailure(let errorMessage):
                failure(errorMessage)
            }
        }
    }
}
