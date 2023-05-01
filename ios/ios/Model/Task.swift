//
//  Resources.swift
//  ios
//
//  Created by Ismail Tever on 27.04.2023.
//

import Foundation

// MARK: - Resource
struct Task: Codable {
    let task: String?
    let title: String?
    let description: String?
    let sort: String?
    let wageType: String?
    let businessUnitKey: String?
    let businessUnit: String?
    let parentTaskID: String?
    let preplanningBoardQuickSelect: String?
    let colorCode: String?
    let workingTime: String?
    let isAvailableInTimeTrackingKioskMode: Bool?
    
    enum CodingKeys: String, CodingKey {
        case task = "task"
        case title = "title"
        case description = "description"
        case sort = "sort"
        case wageType = "wageType"
        case businessUnitKey = "BusinessUnitKey"
        case businessUnit = "businessUnit"
        case parentTaskID = "parentTaskID"
        case preplanningBoardQuickSelect = "preplanningBoardQuickSelect"
        case colorCode = "colorCode"
        case workingTime = "workingTime"
        case isAvailableInTimeTrackingKioskMode = "isAvailableInTimeTrackingKioskMode"
    }
}
