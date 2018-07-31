//
//  HomeViewModel.swift
//  weatherApp
//
//  Created by Sumit Ghosh on 31/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import UIKit
import CoreLocation

public final class HomeViewModel {
    //In viewmodel all the manipulation of data takes place 
    
    //MARK: Instance properties
    let weatherResponse:Response
    let address:String!
    let summary:String!
    let temperature:String!
    let weatherIconType:String!
    let place:CLPlacemark!
    
    //MARK:Object Model
    init(weatherResponse:Response, place:CLPlacemark) {
        self.weatherResponse = weatherResponse
        self.place = place
        self.summary = self.weatherResponse.currently?.summary ?? ""
        let country = self.place.country ?? "NA"
        let state = self.place.administrativeArea ?? "NA"
        let city = self.place.locality ?? "NA"
        self.address = "\(city),\(state),\(country)"
        let tempF = self.weatherResponse.currently?.temperature ?? 0
        let tempC = (tempF - 32) * 5/9
        self.temperature = "\(String(tempC.rounded()))° C"
        self.weatherIconType = self.weatherResponse.currently?.icon ?? ""
    }
}
