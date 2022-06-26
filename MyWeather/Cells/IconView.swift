//
//  IconView.swift
//  MyWeather
//
//  Created by Alexandre Josien on 26/06/2022.
//

import UIKit

class IconView: UIView {

    lazy var image: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    init()
    {
        super.init(frame: .zero)
        backgroundColor = .systemBlue
        addSubview(image)
        
        image.edges(to: self, insets: .init(top: 40, left: 15, bottom: 40, right: 15))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(systemeName: String)
    {
        self.image.image = UIImage(systemName: systemeName)?
            .withRenderingMode(.alwaysOriginal)
    }
    
    func setImage(apiName: String)
    {
        let transformer = [
            "01d": "sun.max.fill",
            "01n": "moon.fill",
            
            "02d": "cloud.sun.fill",
            "02n": "cloud.moon.fill",
            
            "03d": "cloud.fill",
            "03n": "cloud.fill",
            
            "04d": "cloud.fill",
            "04n": "cloud.fill",
            
            "09d": "cloud.rain.fill",
            "09n": "cloud.rain.fill",
            
            "10d": "cloud.sun.rain.fill",
            "10n": "cloud.moon.rain.fill",
            
            "11d": "cloud.bolt.fill",
            "11n": "cloud.bolt.fill",
            
            "13d": "cloud.snow.fill",
            "13n": "cloud.snow.fill",
            
            "50d": "cloud.fog.fill",
            "50n": "cloud.fog.fill",
        ]
        setImage(systemeName: transformer[apiName] ?? "sun.max.fill")
    }
    
}
