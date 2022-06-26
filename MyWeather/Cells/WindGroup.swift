//
//  WindGroup.swift
//  MyWeather
//
//  Created by Alexandre Josien on 26/06/2022.
//

import UIKit
import TinyConstraints

class WindGroup: UIView {

    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Wind"
        lbl.font = UIFont(name: "AvenirNext", size: 20)
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var speedLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-DemiBold", size: 29)
        lbl.textColor = UIColor(named: "windColor")
        lbl.text = "-"
        return lbl
    }()
    
    lazy var directionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-DemiBold", size: 29)
        lbl.textColor = UIColor(named: "windColor")
        lbl.text = "-"
        return lbl
    }()
    
    init()
    {
        super.init(frame: .zero)
        
        addSubview(nameLabel)
        addSubview(speedLabel)
        addSubview(directionLabel)
        
        nameLabel.edges(to: self, excluding: .bottom)
        
        speedLabel.leading(to: self)
        speedLabel.bottom(to: self)
        speedLabel.topToBottom(of: nameLabel)
        
        directionLabel.trailing(to: self)
        directionLabel.bottom(to: self)
        directionLabel.topToBottom(of: nameLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func degToDir(deg: Int) -> String
    {
        let sectors = ["N","NNE","NE","ENE","E","ESE","SE","SSE","S","SSW","SW","WSW","W","WNW","NW","NNW","N"]
        return sectors[Int(round(Double(deg).truncatingRemainder(dividingBy: 360)) / 22.5)]
    }
    
    func populate(wind: WindModel)
    {
        speedLabel.text = String(Int(round(wind.speed * 1.943844)))
        directionLabel.text = degToDir(deg: wind.deg)
    }
    
}
