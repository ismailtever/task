//
//  APIHandler.swift
//  ios
//
//  Created by Ismail Tever on 27.04.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func request<T: Decodable>(type: T.Type, url: String, headers:HTTPHeaders?, params:[String:Any]?, method:HTTPMethod, completion: @escaping(NetworkResponse<T>)->Void) {
        AF.request(url,
                   method: method,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: headers).responseData { response in
            self.handleResponseData(response: response) { complete in
                completion(complete)
            }
        }
    }
    func handleResponseData<T: Decodable>(response: AFDataResponse<Data>, completion: (NetworkResponse<T>) -> ()) {
        if let code = response.response?.statusCode {
            print("responseCode: \(code)")
            switch code {
            case 200...299:
                guard let data = response.data, let model = try? JSONDecoder().decode(T.self, from: data) else { return }
                //print("responseModel: \(String(data: data, encoding: .utf8) ?? "no model")")
                completion(.success(model))
                
            default:
                guard let data = response.data, let model = try? JSONDecoder().decode(ErrorMessage.self, from: data) else { return }
                completion(.messageFailure(model))
            }
        }
    }
    
    
}
