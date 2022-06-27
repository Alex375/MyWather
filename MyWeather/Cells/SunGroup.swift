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
            .withRenderingMode(.automatic)
        return iv
    }()
    
    lazy var sunsetImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "sunset.fill")?
            .withRenderingMode(.automatic)
        return iv
    }()
    
    init()
    {
        super.init(frame: .zero)
        
        let iconConfig = UIImage.SymbolConfiguration(paletteColors: [.systemBlue, .systemYellow])
        
        addSubview(sunsetImage)
        addSubview(sunriseImage)
        addSubview(sunsetLabel)
        addSubview(sunriseLabel)
        
        sunriseLabel.leading(to: self)
        sunriseLabel.top(to: self)
        sunriseLabel.bottom(to: self)
        
        sunriseImage.leadingToTrailing(of: sunriseLabel, offset: 3)
        sunriseImage.top(to: self, offset: 6)
        sunriseImage.bottom(to: self, offset: -6)
        sunriseImage.widthAnchor.constraint(equalTo: sunriseImage.heightAnchor, multiplier: 1.4).isActive = true
        
        sunsetLabel.trailing(to: self)
        sunsetLabel.top(to: self)
        sunsetLabel.bottom(to: self)
        
        sunsetImage.trailingToLeading(of: sunsetLabel, offset: -3)
        sunsetImage.top(to: self, offset: 6)
        sunsetImage.bottom(to: self, offset: -6)
        sunsetImage.widthAnchor.constraint(equalTo: sunsetImage.heightAnchor, multiplier: 1.4).isActive = true
        
        sunsetImage.preferredSymbolConfiguration = iconConfig
        sunriseImage.preferredSymbolConfiguration = iconConfig
        
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
