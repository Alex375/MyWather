//
//  WindCVCell.swift
//  MyWeather
//
//  Created by Alexandre Josien on 03/07/2022.
//

import Foundation
import UIKit

class WindCVCell: ForecastCollectionViewCell
{
    
    lazy var speedLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-DemiBold", size: 24)
        lbl.textAlignment = .center
        lbl.textColor = UIColor(named: "windColor")
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    lazy var directionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext", size: 20)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    override class var id: String {
        return "WindCVCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(directionLabel)
        contentView.addSubview(speedLabel)
        
        speedLabel.centerY(to: contentView)
        speedLabel.leading(to: contentView)
        speedLabel.trailing(to: contentView)
        
        directionLabel.edges(to: contentView, excluding: .top)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func degToDir(deg: Int) -> String
    {
        let sectors = ["N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW","N"]
        return sectors[Int(round(Double(deg).truncatingRemainder(dividingBy: 360)) / 22.5)]
    }
    
    override func populate(weather: ForecastElement, offset: Double) {
        super.populate(weather: weather, offset: offset)
        
        speedLabel.text = String(UnitConverter.speed(speed: weather.wind.speed)) + UnitConverter.speedUnitSuffix()
        directionLabel.text = degToDir(deg: weather.wind.deg)
    }
}
