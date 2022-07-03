//
//  ForecastCollectionViewCell.swift
//  MyWeather
//
//  Created by Alexandre Josien on 03/07/2022.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    class var id: String {
        return "ForecastCollectionViewCell"
    }
    
    lazy var hourLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext", size: 20)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        contentView.addSubview(hourLabel)
        
        hourLabel.edges(to: contentView, excluding: .bottom)
        hourLabel.width(50)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(weather: ForecastElement, offset: Double)
    {
        let date = Date(timeIntervalSince1970: weather.dt + offset)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH"
        hourLabel.text = dateFormatter.string(from: date) + "h"
        
    }
    
}
