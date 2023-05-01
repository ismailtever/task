//
//  Auth.swift
//  ios
//
//  Created by Ismail Tever on 27.04.2023.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let oauth: Oauth?
    let userInfo: UserInfo?
}

// MARK: - Oauth
struct Oauth: Codable {
    let accessToken: String?
    let expiresIn: Int?
    let tokenType: String?
    let refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
    }
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let personalNo: Int?
    let firstName: String?
    let lastName: String?
    let displayName: String?
    let active: Bool?
    let businessUnit: String?

    enum CodingKeys: String, CodingKey {
        case personalNo = "personelNo"
        case firstName = "firstName"
        case lastName = "lastName"
        case displayName = "displayName"
        case active = "active"
        case businessUnit = "businessUnit"
    }
}
