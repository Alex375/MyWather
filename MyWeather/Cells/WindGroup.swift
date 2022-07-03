//
//  WindGroup.swift
//  MyWeather
//
//  Created by Alexandre Josien on 26/06/2022.
//

import UIKit
import TinyConstraints

class WindGroup: UIView {
    
    private var details = false
    
    var defaultConstrains = Constraints()
    var detailsConstrains = Constraints()
    
    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "main.wind".localized
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
    
    lazy var gustLabel: TempLabel = {
        let lbl = TempLabel(name: "main.gust".localized)
        lbl.infoLabel.textColor = UIColor(named: "windColor")
        lbl.info = "-"
        lbl.infoLabel.trailing(to: lbl)
        lbl.nameLabel.trailing(to: lbl)
        return lbl
    }()
    
    lazy var degLabel: TempLabel = {
        let lbl = TempLabel(name: "main.direction".localized)
        lbl.infoLabel.textColor = UIColor(named: "windColor")
        lbl.infoLabel.trailing(to: lbl)
        lbl.nameLabel.trailing(to: lbl)
        lbl.info = "-"
        return lbl
    }()
    
    init()
    {
        super.init(frame: .zero)
        
        addSubview(nameLabel)
        addSubview(gustLabel)
        addSubview(degLabel)
        addSubview(speedLabel)
        addSubview(directionLabel)
        
        nameLabel.edges(to: self, excluding: .bottom)
        
        speedLabel.leading(to: self)
        defaultConstrains.append(speedLabel.bottom(to: self))
        speedLabel.topToBottom(of: nameLabel)
        
        directionLabel.trailing(to: self)
        defaultConstrains.append(directionLabel.bottom(to: self))
        directionLabel.topToBottom(of: nameLabel)
        
        gustLabel.leading(to: self)
        degLabel.trailing(to: self)
        
        gustLabel.isHidden = true
        degLabel.isHidden = true
        
        defaultConstrains.append(gustLabel.top(to: self))
        defaultConstrains.append(degLabel.top(to: self))
        detailsConstrains.append(gustLabel.bottom(to: self, isActive: false))
        detailsConstrains.append(degLabel.bottom(to: self, isActive: false))
        
        detailsConstrains.append(gustLabel.topToBottom(of: speedLabel, offset: 10, isActive: false))
        detailsConstrains.append(degLabel.topToBottom(of: speedLabel, offset: 10, isActive: false))
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
        let suffix = UnitConverter.speedUnitSuffix()
        speedLabel.text = String(UnitConverter.speed(speed: wind.speed)) + suffix
        directionLabel.text = degToDir(deg: wind.deg).localized
        if let gust = wind.gust {
            gustLabel.info = String(UnitConverter.speed(speed: gust)) + suffix
        }
        degLabel.info = String(wind.deg) + "°"
    }
    
    func setDetails(to detail: Bool, animate: Bool)
    {
        if detail == self.details {
            return
        }
        
        
        
        if detail
        {
            gustLabel.isHidden = false
            degLabel.isHidden = false
            defaultConstrains.deActivate()
            detailsConstrains.activate()
        }
        else
        {
            detailsConstrains.deActivate()
            defaultConstrains.activate()
        }
        
        if animate
        {
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            } completion: { done in
                if !detail
                {
                    self.gustLabel.isHidden = true
                    self.degLabel.isHidden = true
                }
            }

        }
        else
        {
            if !detail
            {
                gustLabel.isHidden = true
                degLabel.isHidden = true
            }
            layoutIfNeeded()
        }
        details = detail
    }
    
}
