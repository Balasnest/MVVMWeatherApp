//
//  ViewController.swift
//  weatherApp
//
//  Created by Sumit Ghosh on 26/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import UIKit
import SwiftyGif

class ViewController: UIViewController,SearchPlaceDelegate {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weahterImage: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var weatherView: UIView!
    var homeViemModel:HomeViewModel!
    
    struct StoryBoardID {
        static let SEARCH_SCREEN = "searchScreen"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDefaultValue()
    }
    
    //MARK: Segue data handling method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoardID.SEARCH_SCREEN {
            let searchScreen = segue.destination as! SearchViewController
            searchScreen.delegate = self as SearchPlaceDelegate
        }
    }

    //MARK: FetchData from API
    func fetchData(latitude:String,longitude:String) -> Void {
        self.weatherView.isHidden = true
        self.activityView.isHidden = false
        APIHelper.sharedinstance.getWeatherData(latitude: latitude, longitude: longitude) { (response, error) in
             DispatchQueue.main.async {[unowned self] in
                //calling method for getting the address 
                self.getAddress(response: response!)
            }
        }
    }
    //MARK: Set Color for status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Get Address from Co ordinates
    func getAddress(response:Response) -> Void {
        Utility.shared.convertCoordinateToAddress(latitude: response.latitude ?? 0, longitude: response.longitude ?? 0, completion: { (place, error) in
            if error == nil {
                //calling the view model
                self.homeViemModel = HomeViewModel.init(weatherResponse: response, place: place!)
                self.setRealData()
                self.weatherView.isHidden = false
                self.activityView.isHidden = true
            }else{
               self.setDefaultValue()
            }
        })
    }
    //MARK: Set Real Data
    func setRealData() -> Void {
        self.conditionLabel.text = self.homeViemModel.summary
        self.temperatureLabel.text = self.homeViemModel.temperature
        self.placeLabel.text = self.homeViemModel.address
        let weatherCondition = WeatherType.init(rawValue: self.homeViemModel.weatherIconType)
        self.determineWeatherImage(number: (weatherCondition?.description)!)
    }
    
    //MARK: Setting default value for UI
    func setDefaultValue() {
        self.placeLabel.text = ""
        self.temperatureLabel.text = ""
        self.conditionLabel.text = "Tap on Search to Start"
        self.weahterImage.image = nil
        self.backgroundImage.image = nil
    }
    
    //MARK: Determine weather type and add image
    func determineWeatherImage(number:Int) -> Void {
        switch number {
        case 1:
            self.lightingStorm()
            break
        case 2:
            self.sunnyWeather()
            break
        case 3:
            self.rainWeather()
            break
        case 4:
            self.cloudyWeather()
            break
        default:
            self.winterWeather()
            break
        }
    }
    
    //MARK: adding asset for storm
    func lightingStorm() -> Void {
        let gif = UIImage(gifName: "lightingStorm")
        self.backgroundImage.setGifImage(gif, loopCount: -1)
        self.weahterImage.image = #imageLiteral(resourceName: "storm")
    }
    
    //MARK: Adding asset for sunny/clear weather
    func sunnyWeather() -> Void {
        let gif = UIImage(gifName: "sunny")
        self.backgroundImage.setGifImage(gif, loopCount: -1)
        self.weahterImage.image = #imageLiteral(resourceName: "sunny")
    }
    
    //MARK: Adding asset for rain/drizzle/sleet
    func rainWeather() -> Void {
        let gif = UIImage(gifName: "rain")
        self.backgroundImage.setGifImage(gif, loopCount: -1)
        self.weahterImage.image = #imageLiteral(resourceName: "rain")
    }
    
    //MARK: Adding asset for overcast/cloudy weather
    func cloudyWeather() -> Void {
        let gif = UIImage(gifName: "cloudy")
        self.backgroundImage.setGifImage(gif, loopCount: -1)
        self.weahterImage.image = #imageLiteral(resourceName: "cloudy")
    }
    
    //MARK: Adding asset for Fog/Snow/Cold
    func winterWeather() -> Void {
        let gif = UIImage(gifName: "winter")
        self.backgroundImage.setGifImage(gif, loopCount: -1)
        self.weahterImage.image = #imageLiteral(resourceName: "winter")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

