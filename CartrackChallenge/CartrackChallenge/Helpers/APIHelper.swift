//
//  APIHelper.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import Foundation
class APIHelper {
    class func response(withRequest request: URLRequest, success: @escaping (_ data: Data)->Void, failure: @escaping (_ error: Error?)->Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let responseData = data, error == nil {
                success(responseData)
            } else {
                failure(error)
            }
        }
    }
    
    class func request<T: Codable>(withURL urlstring: String, type: HTTPMethod , params: T) -> URLRequest? {
        guard let url = URL(string: urlstring) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        request.httpMethod = type.rawValue
        if type == .get {
            return request
        }
        
        guard let requestParams = try? JSONEncoder().encode(params) else {
            return nil
        }
        request.httpBody = requestParams
        return request
    }
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
