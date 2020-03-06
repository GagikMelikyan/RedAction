//
//  APIManager.swift
//  Red'Action
//
//  Created by Ruzanna Sedrakyan on 12/30/18.
//  Copyright © 2018 Ruzanna Sedrakyan. All rights reserved.
//

import Foundation
import UIKit

enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}

class APIManager {
    
    static let sharedInstance: APIManager = {        
        let instance = APIManager()
        return instance
    }()
    
    func fetchNews(withUrl: String, completionHandler: @escaping ([News]?, Error?) -> Void) {
        
        guard let url = URL(string: withUrl ) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        var headers = urlRequest.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        urlRequest.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let news = try decoder.decode([News].self, from: responseData)
                
                completionHandler(news, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
    func fetchEachNews(id: Int, completionHandler: @escaping (Article?, Error?) -> Void) {
        
        guard let url = URL(string: "https://www.redaction.media/wp-json/wp/v2/articles/\(id)?_embed") else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        var headers = urlRequest.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        urlRequest.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let article = try decoder.decode(Article.self, from: responseData)
                completionHandler(article, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
    func registerUser(parameters: User, completion: @escaping (Error?, _ statusCode: Int?) -> Void) {
        
        let username = "admin"
        let password = "Satilmis30052015"
        let loginString = "\(username):\(password)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        guard let url = URL(string: "https://www.redaction.media/wp-json/wp/v2/users") else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(parameters)
            
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion(error, nil)
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    let message: String = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                    print(message)
                    
                    completion(nil, response.statusCode)
                }
            }
            
            do {
                if let stringDict = try JSONSerialization.jsonObject(with: responseData!, options: []) as? [String : Any] {
                    print(stringDict)
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
}
