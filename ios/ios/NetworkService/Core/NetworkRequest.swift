//
//  NetworkRequest.swift
//  ios
//
//  Created by Ismail Tever on 28.04.2023.
//

import Foundation
import Alamofire

final class NetworkRequest {
    static let shared = NetworkRequest()
    
    var params: [String: Any]?
    
    func post<T: Decodable>(type: T.Type, url: String, params: [String: Any] = [:], completion: @escaping((Result<T, ErrorTypes>))->Void) {
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: NetworkHelper.shared.header()).responseData { response in
            self.handleResponseData(response: response) { complete in
                completion(complete)
            }
        }
    }
    
    func get<T: Decodable>(type: T.Type, url: String, completion: @escaping((Result<T, ErrorTypes>))->Void) {
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: NetworkHelper.shared.header()).responseData { response in
                    self.handleResponseData(response: response) { complete in
                        completion(complete)
                    }
        }
    }
    
    func handleResponseData<T: Decodable>(response: AFDataResponse<Data>, completion: ((Result<T, ErrorTypes>)) -> ()) {
        if let code = response.response?.statusCode {
            print("responseCode: \(code)")
            switch code {
            case 200...299:
                guard let data = response.data, let model = try? JSONDecoder().decode(T.self, from: data) else { return }
                print("responseModel: \(String(data: data, encoding: .utf8) ?? "no model")")
                completion(.success(model))
                
            default:
                guard let data = response.data, let model = try? JSONDecoder().decode(ErrorMessage.self, from: data) else { return }
                completion(.failure(ErrorTypes.invalidData))
            }
        }
    }
}
