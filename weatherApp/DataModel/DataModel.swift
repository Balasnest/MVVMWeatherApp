//
//  DataModel.swift
//  weatherApp
//
//  Created by Sumit Ghosh on 28/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation
import UIKit

//Data model for response from DARK SKY API (weather)
struct Response: Decodable {
    let latitude: Double?
    let longitude: Double?
    let timezone: String?
    let currently: currentData?
}

struct currentData: Decodable {
    let time: Int?
    let summary: String?
    let icon: String?
    let nearestStormDistance: Double?
    let nearestStormBearing: Double?
    let precipIntensity: Double?
    let precipProbability: Double?
    let temperature: Double?
    let apparentTemperature: Double?
    let dewPoint: Double?
    let humidity: Double?
    let pressure: Double?
    let windSpeed: Double?
    let windGust: Double?
    let windBearing: Double?
    let cloudCover: Double?
    let uvIndex: Double?
    let visibility: Double?
    let ozone: Double?
}
