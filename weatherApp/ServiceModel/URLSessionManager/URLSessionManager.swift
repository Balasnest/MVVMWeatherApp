//
//  URLSessionManager.swift
//  weatherApp
//
//  Created by Sumit Ghosh on 28/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation
import UIKit

class URLSessionManager: NSObject {
    static let share = URLSessionManager()
    
    //Setting URLSessionConfiguration
    private func defaultSessionConfiguration() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30.0
        config.timeoutIntervalForResource = 60.0
        return config
    }
    
    //Setting the session for background configuration
    private func configureBackgroundSession(_ identifier: String) -> URLSessionConfiguration {
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: identifier)
        return sessionConfig
    }
    
    //Creating session instance
    private func getSharedSession() -> URLSession {
        let session = URLSession.shared
        return session
    }
    
    //Get Request
    func getRequest(with url: URL, completionHandler: @escaping (Data?, NSError?) -> Void) -> Void {
        
        let headers = [
            "cache-control": Configuration.CACHE_CONTROL,
            "postman-token": Configuration.TOKEN
        ]
        
        var urlRequest = URLRequest.init(url: url, cachePolicy:.useProtocolCachePolicy , timeoutInterval: 10)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        
        let dataTask = self.getSharedSession().dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                completionHandler(nil, NSError.serviceError(error!.localizedDescription))
                return
            }
            
            let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                completionHandler(data, nil)
            }
            else {
                    completionHandler(nil, NSError.serviceError(error!.localizedDescription))
                }
            }
        dataTask.resume()
    }
}
