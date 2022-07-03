//
//  IconMaganger.swift
//  MyWeather
//
//  Created by Alexandre Josien on 01/07/2022.
//

import Foundation
import UIKit


class IconManager
{
    static var iconMapD = [
        "800": "sun.max.fill", //
        "801": "cloud.sun.fill", //
        "802": "cloud.fill",
        "803": "cloud.fill",
        "804": "cloud.fill",
        
        "701": "cloud.fog.fill",
        "711": "smoke.fill",
        "721": "sun.haze.fill",//
        "731": "sun.dust.fill",//
        "741": "cloud.fog.fill",
        "751": "sun.dust.fill",//
        "761": "sun.dust.fill",//
        "762": "sun.dust.fill",//
        "771": "sun.dust.fill",//
        "781": "tornado",
        
        "200": "cloud.bolt.rain.fill",
        "201": "cloud.bolt.rain.fill",
        "202": "cloud.bolt.rain.fill",
        "210": "cloud.sun.bolt.fill",//
        "211": "cloud.bolt.fill",
        "212": "cloud.bolt.fill",
        "221": "cloud.bolt.fill",
        "230": "cloud.bolt.rain.fill",
        "231": "cloud.bolt.rain.fill",
        "232": "cloud.bolt.rain.fill",
        
        "300": "cloud.drizzle.fill",
        "301": "cloud.drizzle.fill",
        "302": "cloud.drizzle.fill",
        "310": "cloud.rain.fill",
        "311": "cloud.rain.fill",
        "312": "cloud.rain.fill",
        "313": "cloud.rain.fill",
        "314": "cloud.rain.fill",
        "321": "cloud.drizzle.fill",
        
        "500": "cloud.sun.rain.fill", //
        "501": "cloud.sun.rain.fill", //
        "502": "cloud.rain.fill",
        "503": "cloud.heavyrain.fill",
        "504": "cloud.heavyrain.fill",
        "511": "cloud.sleet.fill",
        "520": "cloud.rain.fill",
        "521": "cloud.rain.fill",
        "522": "cloud.heavyrain.fill",
        "531": "cloud.heavyrain.fill",
        
        "600": "cloud.snow.fill",
        "601": "cloud.snow.fill",
        "602": "cloud.snow.fill",
        "611": "cloud.hail.fill",
        "612": "cloud.hail.fill",
        "613": "cloud.hail.fill",
        "615": "cloud.hail.fill",
        "616": "cloud.hail.fill",
        "620": "cloud.snow.fill",
        "621": "cloud.snow.fill",
        "622": "cloud.snow.fill",
    ]
    
    static var colorMapD = [
        "800": #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1), //
        "801": #colorLiteral(red: 0.3473195632, green: 0.6016559959, blue: 0.9992237687, alpha: 1), //
        "802": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),
        "803": #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),
        "804": #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
        
        "701": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),
        "711": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),
        "721": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),//
        "731": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),//
        "741": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),
        "751": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),//
        "761": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),//
        "762": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),//
        "771": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),//
        "781": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),
        
        "200": #colorLiteral(red: 0.0372579433, green: 0.518321991, blue: 0.9992237687, alpha: 1),
        "201": #colorLiteral(red: 0.0372579433, green: 0.518321991, blue: 0.9992237687, alpha: 1),
        "202": #colorLiteral(red: 0.0372579433, green: 0.518321991, blue: 0.9992237687, alpha: 1),
        "210": #colorLiteral(red: 0.0372579433, green: 0.518321991, blue: 0.9992237687, alpha: 1),//
        "211": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),
        "212": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),
        "221": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),
        "230": #colorLiteral(red: 0.0372579433, green: 0.518321991, blue: 0.9992237687, alpha: 1),
        "231": #colorLiteral(red: 0.0372579433, green: 0.518321991, blue: 0.9992237687, alpha: 1),
        "232": #colorLiteral(red: 0.0372579433, green: 0.518321991, blue: 0.9992237687, alpha: 1),
        
        "300": #colorLiteral(red: 0.3473195632, green: 0.6016559959, blue: 0.9992237687, alpha: 1),
        "301": #colorLiteral(red: 0.3473195632, green: 0.6016559959, blue: 0.9992237687, alpha: 1),
        "302": #colorLiteral(red: 0.3473195632, green: 0.6016559959, blue: 0.9992237687, alpha: 1),
        "310": #colorLiteral(red: 0.3473195632, green: 0.6016559959, blue: 0.9992237687, alpha: 1),
        "311": #colorLiteral(red: 0.3473195632, green: 0.6016559959, blue: 0.9992237687, alpha: 1),
        "312": #colorLiteral(red: 0.3473195632, green: 0.6016559959, blue: 0.9992237687, alpha: 1),
        "313": #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
        "314": #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
        "321": #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
        
        "500": #colorLiteral(red: 0.0372579433, green: 0.518321991, blue: 0.9992237687, alpha: 1), //
        "501": #colorLiteral(red: 0.3473195632, green: 0.6016559959, blue: 0.9992237687, alpha: 1), //
        "502": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),
        "503": #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
        "504": #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
        "511": #colorLiteral(red: 0.3473195632, green: 0.6016559959, blue: 0.9992237687, alpha: 1),
        "520": #colorLiteral(red: 0.3473195632, green: 0.6016559959, blue: 0.9992237687, alpha: 1),
        "521": #colorLiteral(red: 0.3473195632, green: 0.6016559959, blue: 0.9992237687, alpha: 1),
        "522": #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 1),
        "531": #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
        
        "600": #colorLiteral(red: 0.0372579433, green: 0.518321991, blue: 0.9992237687, alpha: 1),
        "601": #colorLiteral(red: 0.2943957624, green: 0.593317451, blue: 0.9992237687, alpha: 1),
        "602": #colorLiteral(red: 0.3984612825, green: 0.6801421133, blue: 0.9992237687, alpha: 1),
        "611": #colorLiteral(red: 0.2943957624, green: 0.593317451, blue: 0.9992237687, alpha: 1),
        "612": #colorLiteral(red: 0.2943957624, green: 0.593317451, blue: 0.9992237687, alpha: 1),
        "613": #colorLiteral(red: 0.2943957624, green: 0.593317451, blue: 0.9992237687, alpha: 1),
        "615": #colorLiteral(red: 0.2943957624, green: 0.593317451, blue: 0.9992237687, alpha: 1),
        "616": #colorLiteral(red: 0.2943957624, green: 0.593317451, blue: 0.9992237687, alpha: 1),
        "620": #colorLiteral(red: 0.2943957624, green: 0.593317451, blue: 0.9992237687, alpha: 1),
        "621": #colorLiteral(red: 0.2943957624, green: 0.593317451, blue: 0.9992237687, alpha: 1),
        "622": #colorLiteral(red: 0.2943957624, green: 0.593317451, blue: 0.9992237687, alpha: 1),
    ]
    
    
    static var iconMapN = [
        "800": "moon.stars.fill",
        "801": "cloud.moon.fill",
        "210": "cloud.moon.bolt.fill",
        "500": "cloud.moon.rain.fill",
        "501": "cloud.moon.rain.fill"
    ]
    
    static var colorMapN = [
        "800": #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1),
        "801": #colorLiteral(red: 0.3686270118, green: 0.3608806729, blue: 0.901634872, alpha: 1),
        "210": #colorLiteral(red: 0.3686270118, green: 0.3608806729, blue: 0.901634872, alpha: 1),
        "500": #colorLiteral(red: 0.3686270118, green: 0.3608806729, blue: 0.901634872, alpha: 1),
        "501": #colorLiteral(red: 0.2831510908, green: 0.2764616122, blue: 0.7010125494, alpha: 1)
    ]
    
    static func getIcon(weather: SubWeatherModel) -> UIImage
    {
        let questionImage = UIImage(systemName: "questionmark")!
        let id = String(weather.id)
        if weather.icon.last == "n"
        {
            if iconMapN.keys.contains(id) {
                return UIImage(systemName: iconMapN[id] ?? "") ?? questionImage
            }
        }
        return UIImage(systemName: iconMapD[id] ?? "") ?? questionImage
    }
    
    static func getColor(weather: SubWeatherModel) -> UIColor
    {
        let id = String(weather.id)
        if weather.icon.last == "n"
        {
            if colorMapN.keys.contains(id) {
                return colorMapN[id] ?? UIColor.systemBlue
            }
            else {
                return #colorLiteral(red: 0.3686270118, green: 0.3608806729, blue: 0.901634872, alpha: 1)
            }
        }
        return colorMapD[id] ?? UIColor.systemBlue
    }
}
