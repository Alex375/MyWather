//
//  ForecastModel.swift
//  MyWeather
//
//  Created by Alexandre Josien on 03/07/2022.
//

import Foundation

struct SystemModel: Decodable
{
    let pod: String
}


struct ForecastRainModel: Codable
{
    let threeH: Double
    
    enum CodingKeys: String, CodingKey {
        case threeH = "3h"
    }
}

struct ForeCastCityModel: Decodable
{
    let timezone: Double
}

struct ForecastSnowModel: Codable
{
    let threeH: Double
    
    enum CodingKeys: String, CodingKey {
        case threeH = "3h"
    }
}


struct ForecastElement: Decodable
{
    let dt: Double
    let main: MainModel
    let weather: [SubWeatherModel]
    let clouds: CloudModel
    let wind: WindModel
    let visibility: Double
    let pop: Double
    let rain: ForecastRainModel?
    let snow: ForecastSnowModel?
    let sys: SystemModel
}

struct ForecastModel: Decodable
{
    let cnt: Int
    let list: [ForecastElement]
    let city: ForeCastCityModel
}
