//
//  WeatherManager.swift
//  MyWeather
//
//  Created by Alexandre Josien on 25/06/2022.
//

import Foundation
import CoreLocation
import Alamofire

func getApiKey() -> String?
{
    if let apikey = Bundle.main.infoDictionary?["OPEN_WEATHER_MAP_APPID"] as? String {
        return apikey
    }
    return nil
}

func getWeather(location: CLLocationCoordinate2D, completion: @escaping(WeatherModel?, Error?) -> Void)
{
    let apiKey = getApiKey()
    guard let apiKey = apiKey else {
        return
    }
    let parmeters = [
        "lat": String(location.latitude),
        "lon": String(location.longitude),
        "appid":apiKey,
        "units": UnitConverter.getApiUnitParam(),
        "lang": "api.lang".localized
    ]
    AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: parmeters).responseDecodable(of: WeatherModel.self) { response in
        switch response.result{
        case .success(let res):
            completion(res, nil)
        case .failure(let fail):
            completion(nil, fail)
        }
    }
    
//    AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: parmeters).responseJSON { respons in
//        switch respons.result {
//        case .success(let succes):
//            print(succes)
//        case .failure(let fail):
//            print(fail)
//        }
//    }
}

func getGeoCoding(city: String, completion: @escaping([CityModel]?, Error?) -> Void)
{
    let apiKey = getApiKey()
    guard let apiKey = apiKey else {
        return
    }
    let parameters = [
        "q": city,
        "limit": String(50),
        "appid": apiKey
    ]
    AF.request("https://api.openweathermap.org/geo/1.0/direct", parameters: parameters).responseDecodable(of: [CityModel].self) { response in
        switch response.result
        {
        case .success(let success):
            completion(success, nil)
        case .failure(let failure):
            completion(nil, failure)
        }
    }
//    AF.request("https://api.openweathermap.org/geo/1.0/direct", parameters: parameters).responseJSON { response in
//        switch response.result
//        {
//        case .success(let success):
//            print(success)
//        case .failure(let failure):
//            completion(nil, failure)
//        }
//    }
}

func getForecast(location: CLLocationCoordinate2D, completion: @escaping(ForecastModel?, Error?) -> Void)
{
    let apiKey = getApiKey()
    guard let apiKey = apiKey else {
        return
    }
    let parameters = [
        "lat": String(location.latitude),
        "lon": String(location.longitude),
        "appid":apiKey,
        "units": UnitConverter.getApiUnitParam(),
        "lang": "api.lang".localized
    ]
    
    AF.request("https://api.openweathermap.org/data/2.5/forecast", parameters: parameters).responseDecodable(of: ForecastModel.self) { response in
        switch response.result {
        case .success(let success):
            completion(success, nil)
        case .failure(let failure):
            completion(nil, failure)
        }
    }
    
//    AF.request("https://api.openweathermap.org/data/2.5/forecast", parameters: parameters).responseJSON { response in
//            switch response.result
//            {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                completion(failure)
//            }
//        }
}
