//
//  Task.swift
//  ios
//
//  Created by Ismail Tever on 1.05.2023.
//

import Foundation
class TaskService {
    static let shared = TaskService()

    func getUserTasks(success: @escaping([Task])->(), failure: @escaping(ErrorMessage)->()) {
        NetworkManager.shared.request(type: [Task].self, url: Request.tasks.path, headers: Header.shared.header(tokenType: TokenType.bearer), params: nil, method: .get) { response in
            switch response {
            case .success(let tasks):
                success(tasks)
                
            case .messageFailure(let errorMessage):
                failure(errorMessage)
            }
        }
    }
}
