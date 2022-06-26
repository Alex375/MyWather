//
//  SunGroup.swift
//  MyWeather
//
//  Created by Alexandre Josien on 26/06/2022.
//

import UIKit
import TinyConstraints

class SunGroup: UIView {

    lazy var sunriseLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-DemiBold", size: 29)
        lbl.textColor = UIColor(named: "hourColor")
        lbl.text = "-"
        return lbl
    }()
    
    lazy var sunsetLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-DemiBold", size: 29)
        lbl.textColor = UIColor(named: "hourColor")
        lbl.text = "-"
        return lbl
    }()
    
    lazy var sunriseImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "sunrise.fill")?
            .withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    lazy var sunsetImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "sunset.fill")?
            .withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    init()
    {
        super.init(frame: .zero)
        
        addSubview(sunsetImage)
        addSubview(sunriseImage)
        addSubview(sunsetLabel)
        addSubview(sunriseLabel)
        
        sunriseLabel.leading(to: self)
        sunsetImage.leadingToTrailing(of: sunsetLabel)
        
        sunsetLabel.trailing(to: self)
        sunsetImage.trailingToLeading(of: sunsetLabel)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func populateLabels(sunrise: Double, sunset: Double)
    {
        let sunsetDate = Date(timeIntervalSince1970: sunset)
        let sunriseDate = Date(timeIntervalSince1970: sunrise)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        
        sunsetLabel.text = dateFormatter.string(from: sunsetDate)
        sunriseLabel.text = dateFormatter.string(from: sunriseDate)
    }
    
}
