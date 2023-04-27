//
//  Resources.swift
//  ios
//
//  Created by Ismail Tever on 27.04.2023.
//

import Foundation

// MARK: - Resource
struct Resource: Codable {
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
        case task = "Task"
        case title = "Title"
        case description = "Description"
        case sort = "Sort"
        case wageType = "WageType"
        case businessUnitKey = "BusinessUnitKey"
        case businessUnit = "BusinessUnit"
        case parentTaskID = "ParentTaskID"
        case preplanningBoardQuickSelect = "PreplanningBoardQuickSelect"
        case colorCode = "ColorCode"
        case workingTime = "WorkingTime"
        case isAvailableInTimeTrackingKioskMode = "IsAvailableInTimeTrackingKioskMode"
    }
}
