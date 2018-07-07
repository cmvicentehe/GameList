//
//  NetworkClient.swift
//  GameList
//
//  Created by Carlos Manuel Vicente Herrero on 7/7/18.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

struct NetworkClient {
        let urlSession: URLSession
        
        init(urlSession: URLSession) {
            self.urlSession = urlSession
        }
        
        init() {
            let urlSession = URLSession(configuration: URLSessionConfiguration.default)
            self.init(urlSession: urlSession)
        }
    
    func performRequest(for urlRequest: URLRequest, completion: @escaping (URLResponse?) -> Void)  {
            var urlResponse: URLResponse? = nil
            self.urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                // TODO: Manage task fail and cancel it
                guard let responseNotNil = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }
                urlResponse = responseNotNil
            }).resume()
        
           completion(urlResponse)
        }
}
