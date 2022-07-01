//
//  CityModel.swift
//  MyWeather
//
//  Created by Alexandre Josien on 29/06/2022.
//

import Foundation

struct CityModel: Decodable
{
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}
