
//
//  Utility.swift
//  weatherApp
//
//  Created by Sumit Ghosh on 30/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation
import  UIKit
import CoreLocation


//Enum for weather type
enum WeatherType:String {
    case CLEAR_DAY = "clear-day"
    case CLEAR_NIGHT = "clear-night"
    case RAIN = "rain"
    case SNOW = "snow"
    case SLEET = "sleet"
    case FOG = "fog"
    case CLOUDY = "cloudy"
    case PARTLY_CLOUDY_DAY = "partly-cloudy-day"
    case PARTLY_CLOUDY_NIGHT = "partly-cloudy-night"
    case HAIL = "hail"
    case THUNDERSTORM = "thunderstorm"
    case TORNADO = "tornado"
    
    var description:Int {
        switch self {
        case .CLEAR_DAY:
            return 2
        case .CLEAR_NIGHT:
            return 2
        case .CLOUDY:
            return 4
        case .PARTLY_CLOUDY_DAY:
            return 4
        case .PARTLY_CLOUDY_NIGHT:
            return 4
        case .RAIN:
            return 3
        case .SLEET:
            return 3
        case .HAIL:
            return 3
        case .THUNDERSTORM:
            return 1
        case .SNOW:
            return 5
        case .TORNADO:
            return 1
        default:
            return 0
        }
    }
}
class Utility: NSObject {

    static let shared = Utility()
    var weatherType:WeatherType?
    
    //MARK: Convert Address to Coordinates
    func convertAddressToCoordinates(address:String,completionHandler: @escaping(CLLocationCoordinate2D?,Error?) -> Void) -> Void {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                completionHandler(nil, error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                completionHandler(coordinates, nil)
            }
        })
    }
    
    //MARK: Convert Coordinates to Address
    func convertCoordinateToAddress(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                completion(nil, error)
                return
            }
            completion(placemark, nil)
        }
    }
    
}
