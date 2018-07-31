//
//  APIHelper.swift
//  weatherApp
//
//  Created by Sumit Ghosh on 28/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation
import UIKit

class APIHelper: NSObject {
    static let sharedinstance = APIHelper()
    
    
    //MARK: Get Weather
    func getWeatherData(latitude:String,longitude:String,completionHandler: @escaping(Response?, Error?) -> Void) -> Void{
        
        let url = "\(Configuration.BASE_URL)/\(Configuration.CLIENT_SECRET)"
        
        let finalUrl = URL.init(string: "\(url)/\(latitude),\(longitude)")
        
        
        URLSessionManager.share.getRequest(with: finalUrl!) { (data, error) in
            if error != nil {
                completionHandler(nil, error)
            }
            else {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data! as Data)
                    completionHandler(response, error)
                } catch let error {
                    print(error)
                }
            }
        }
    }
}







