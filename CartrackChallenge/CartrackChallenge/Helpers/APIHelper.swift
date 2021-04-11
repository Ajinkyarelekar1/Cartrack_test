//
//  APIHelper.swift
//  CartrackChallenge
//
//  Created by venajr on 11/4/21.
//

import Foundation
import SVProgressHUD

class APIHelper {
    class func response(withRequest request: URLRequest, success: @escaping (_ data: Data)->Void, failure: @escaping (_ error: Error?)->Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let responseData = data, error == nil {
                success(responseData)
            } else {
                failure(error)
            }
        }
        dataTask.resume()
    }
    
    class func request(withURL urlstring: String, type: HTTPMethod, params: Data?) -> URLRequest? {
        guard let url = URL(string: urlstring) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        request.httpMethod = type.rawValue
        if type == .get {
            return request
        }
        request.httpBody = params
        return request
    }
    
    class func convertToRequestData <T: Codable>(params: T?) -> Data? {
        return try? JSONEncoder().encode(params)
    }
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}


extension APIHelper {
    class func fetchUsers(success: @escaping (_ users: [User])->Void, failure: @escaping (_ error: String?)->Void) {
        if let request = APIHelper.request(withURL: APIServices.users.endpoint, type: .get, params: nil) {
            SVProgressHUD.show()
            APIHelper.response(withRequest: request) { (responseData) in
                SVProgressHUD.dismiss()
                if let users = JSONDecoder.decodeInStyle([User].self, from: responseData) {
                    success(users)
                } else {
                    failure(nil)
                }
            } failure: { (error) in
                SVProgressHUD.dismiss()
                failure(error?.localizedDescription)
            }
        }
    }
}
