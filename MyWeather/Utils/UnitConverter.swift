//
//  UnitConverter.swift
//  MyWeather
//
//  Created by Alexandre Josien on 01/07/2022.
//

import Foundation

enum Settings: String
{
    case speedUnit = "speed-unit"
    case tempUnit = "temp-unit"
}

enum SpeedUnites: Int
{
    case mps = 0
    case mph = 1
    case kmh = 2
    case knts = 3
}

enum TempUnits: Int
{
    case Metrics = 0
    case Imperial = 1
    case Standart = 2
}

class UnitConverter
{
    static func speed(speed: Double) -> Int
    {
        let speedUnit = SpeedUnites(rawValue: UserDefaults
            .standard
            .integer(forKey: Settings.speedUnit.rawValue))
        
        let tempUnit = TempUnits(rawValue: UserDefaults
            .standard
            .integer(forKey: Settings.tempUnit.rawValue))
        
        guard let speedUnit = speedUnit else { return 0 }
        guard let tempUnit = tempUnit else { return 0 }
        
        var res = speed
        
        
        if tempUnit != .Imperial
        {
            switch speedUnit {
            case .mps:
                break
            case .mph:
                res *= 2.23694
            case .kmh:
                res *= 3.6
            case .knts:
                res *= 1.943844
            }
        }
        else
        {
            switch speedUnit {
            case .mps:
                res *= 0.44704
            case .mph:
                break
            case .kmh:
                res *= 1.60934
            case .knts:
                res *= 0.868976
            }
        }
        return Int(round(res))
        
    }
    
    static func speedUnitSuffix() -> String
    {
        let speedUnit = SpeedUnites(rawValue: UserDefaults
            .standard
            .integer(forKey: Settings.speedUnit.rawValue))
        guard let speedUnit = speedUnit else { return "" }
        
        switch speedUnit {
        case .mps:
            return "mps.suff".localized
        case .mph:
            return "mph.suff".localized
        case .kmh:
            return "kph.suff".localized
        case .knts:
            return "knots.suff".localized
        }
    }
    
    static func getApiUnitParam() -> String
    {
        let tempUnit = TempUnits(rawValue: UserDefaults
            .standard
            .integer(forKey: Settings.tempUnit.rawValue))
        guard let tempUnit = tempUnit else { return "standard" }
        
        switch tempUnit {
        case .Standart:
            return "standard"
        case .Metrics:
            return "metric"
        case .Imperial:
            return "imperial"
        }
    }
}
