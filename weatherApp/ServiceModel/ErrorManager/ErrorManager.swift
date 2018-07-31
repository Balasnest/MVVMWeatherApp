//
//  ErrorManager.swift
//  weatherApp
//
//  Created by Sumit Ghosh on 28/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation

// harsh srivastava
import UIKit

// call the functions to handle the error
extension NSError {
    class func serviceError(_ errorMessage: String)-> NSError{
        return NSError(domain: "Local Error", code:1001,userInfo :[NSLocalizedDescriptionKey:errorMessage])
    }
    
    class func internalServerError(errorCode : Int) -> NSError {
        return NSError(domain: Configuration.ERROR_DOMAIN, code: errorCode, userInfo: [NSLocalizedDescriptionKey: "Internal Server Error Please try again after sometimes "])
    }
}
