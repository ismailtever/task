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
    
    //T.Type dışarıdan alacağım bir Type. Bu Type a göre pars et, handle et.
    func request<T: Codable>(type: T.Type, url: String, method: HTTPMethod, completion: @escaping ((Result<T, ErrorTypes>)->())) {
        
        AF.request(url, method: method).responseDecodable(of: T.self) { response in
            switch response.result{
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(ErrorTypes.generalError))
            }
        }
        
       
    }
    
    fileprivate func handleResponse<T: Codable>(data: Data, completion: @escaping ((Result<T, ErrorTypes>)->())) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            //datayı pars edemeyince
            completion(.failure(ErrorTypes.invalidData))
        }
        
    }
}
