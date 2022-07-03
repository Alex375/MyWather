//
//  WeatherCVCell.swift
//  MyWeather
//
//  Created by Alexandre Josien on 03/07/2022.
//

import Foundation
import UIKit

class WeatherCVCell: ForecastCollectionViewCell
{
    override class var id: String {
        return "WeatherCVCell"
    }
    
    lazy var icon: IconView = {
        let icon = IconView(small: true)
        return icon
    }()
    
    lazy var tempLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext", size: 20)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(icon)
        contentView.addSubview(tempLabel)
        
        icon.center(in: contentView)
        icon.size(.init(width: 30, height: 30))
        icon.layer.cornerRadius = 30 / 2
        icon.defaultConstrains.deActivate()
        icon.detailConstrains.activate()
        
        tempLabel.edges(to: contentView, excluding: .top)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func populate(weather: ForecastElement, offset: Double) {
        super.populate(weather: weather, offset: offset)
        
        
        icon.setImage(weather: weather.weather[0])
        
        tempLabel.text =  String(Int(round(weather.main.temp))) + "°"
    }
    
}
