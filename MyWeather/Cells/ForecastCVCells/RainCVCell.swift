//
//  RainCVCell.swift
//  MyWeather
//
//  Created by Alexandre Josien on 03/07/2022.
//

import Foundation
import UIKit

class RainCVCell: ForecastCollectionViewCell
{
    
    lazy var popLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-DemiBold", size: 27)
        lbl.textAlignment = .center
        lbl.textColor = UIColor(named: "windColor")
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    lazy var mmLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    override class var id: String {
        return "RainCVCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(popLabel)
        contentView.addSubview(mmLabel)
        
        popLabel.centerY(to: contentView)
        popLabel.leading(to: contentView)
        popLabel.trailing(to: contentView)
        
        mmLabel.edges(to: contentView, excluding: .top)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func populate(weather: ForecastElement, offset: Double) {
        super.populate(weather: weather, offset: offset)
        
        popLabel.text = String(Int(weather.pop * 100)) + "%"
        mmLabel.text = String(round((weather.rain?.threeH ?? 0) * 10) / 10) + "mm"
    }
}
