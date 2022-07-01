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

func getWeather(location: CLLocationCoordinate2D, completion: @escaping(WeatherModel) -> Void)
{
    let apiKey = getApiKey()
    guard let apiKey = apiKey else {
        return
    }
    let parmeters = [
        "lat": String(location.latitude),
        "lon": String(location.longitude),
        "appid":apiKey,
        "units": "metric",
    ]
    AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: parmeters).responseDecodable(of: WeatherModel.self) { response in
        switch response.result{
        case .success(let res):
            completion(res)
        case .failure(let fail):
            print(fail.localizedDescription)
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
