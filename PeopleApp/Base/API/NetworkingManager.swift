//
//  NetworkingManager.swift
//  PeopleApp
//
//  Created by Sander Haug on 17/06/2023.
//

import Foundation

final class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Codable>(_ endpoint: Endpoint,
                            type: T.Type,
                            completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = endpoint.url else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let res = try decoder.decode(T.self, from: data)
                
                completion(.success(res))
                
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
        }
        dataTask.resume()
    }
    
    func request(_ endpoint: Endpoint,
                completion: @escaping (Result<Void, Error>) -> Void) {
            
        
        guard let url = endpoint.url else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            completion(.success(()))
        }
        dataTask.resume()
    }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

extension NetworkingManager.NetworkingError {
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "URL is not valid"
        case .invalidStatusCode:
            return "Status code falls into the wrong range"
        case .invalidData:
            return "Response is invalid"
        case .failedToDecode:
            return "Failed to decode"
        case .custom(let err):
            return "Something went wrong \(err.localizedDescription)"
        }
        
    }
}

private extension NetworkingManager {
    func buildRequest(  from url: URL,
                        methodType: Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        return request
    }
}
