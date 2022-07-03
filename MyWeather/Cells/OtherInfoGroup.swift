//
//  OtherInfoGroup.swift
//  MyWeather
//
//  Created by Alexandre Josien on 27/06/2022.
//

import UIKit

class OtherInfoGroup: UIView {

    lazy var humidityLabel: TempLabel = {
        let lbl = TempLabel(name: "main.humidity".localized)
        lbl.nameLabel.trailing(to: lbl)
        lbl.infoLabel.trailing(to: lbl)
        lbl.info = "-"
        return lbl
    }()
    
    lazy var pressureLabel: TempLabel = {
        let lbl = TempLabel(name: "main.pressure".localized)
        lbl.nameLabel.trailing(to: lbl)
        lbl.infoLabel.trailing(to: lbl)
        lbl.info = "-"
        return lbl
    }()
    
    init()
    {
        super.init(frame: .zero)
        
        addSubview(humidityLabel)
        addSubview(pressureLabel)
        
        humidityLabel.top(to: self)
        humidityLabel.bottom(to: self)
        humidityLabel.leading(to: self)
        
        pressureLabel.top(to: self)
        pressureLabel.bottom(to: self)
        pressureLabel.trailing(to: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(main: MainModel)
    {
        humidityLabel.info = String(main.humidity) + "%"
        pressureLabel.info = String(main.pressure) + "hPa"
    }
}
