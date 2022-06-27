//
//  WeahterModel.swift
//  MyWeather
//
//  Created by Alexandre Josien on 25/06/2022.
//

import Foundation


struct CoordModel: Decodable
{
    let lon: Double
    let lat: Double
}

struct SubWeatherModel: Decodable
{
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainModel: Decodable
{
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct WindModel: Decodable
{
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct CloudModel: Decodable
{
    let all: Int
}

struct SysModel: Decodable
{
    let sunrise: Double
    let sunset: Double
    let country: String
}

struct RainModel: Codable
{
    let oneH: Double
    let threeH: Double?
    
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
        case threeH = "3h"
    }
}

struct SnowModel: Codable
{
    let oneH: Double
    let threeH: Double?
    
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
        case threeH = "3h"
    }
}



struct WeatherModel: Decodable
{
    let coord: CoordModel
    let weather: [SubWeatherModel]
    let main: MainModel
    let visibility: Int
    let wind: WindModel
    let clouds: CloudModel
    let sys: SysModel
    let timezone: Int
    let name: String
    let rain: RainModel?
    let snow: SnowModel?
    
}
