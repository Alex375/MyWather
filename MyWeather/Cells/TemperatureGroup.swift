//
//  TemperatureGroup.swift
//  MyWeather
//
//  Created by Alexandre Josien on 26/06/2022.
//

import UIKit
import TinyConstraints

class TemperatureGroup: UIView {

    lazy var minInfo: TempLabel = {
        let lbl = TempLabel(name: "Min")
        return lbl
    }()
    
    lazy var feelsLikeInfo: TempLabel = {
        let lbl = TempLabel(name: "Feels like")
        lbl.setType(TempLabel.type.Big)
        return lbl
    }()
    
    lazy var maxInfo: TempLabel = {
        let lbl = TempLabel(name: "Max")
        return lbl
    }()
    
    init()
    {
        super.init(frame: .zero)
        
        addSubview(minInfo)
        addSubview(feelsLikeInfo)
        addSubview(maxInfo)
        
        minInfo.leading(to: self)
        feelsLikeInfo.leadingToTrailing(of: minInfo)
        maxInfo.leadingToTrailing(of: feelsLikeInfo)
        maxInfo.trailing(to: self)
        
        feelsLikeInfo.topToSuperview()
        feelsLikeInfo.bottomToSuperview()
        minInfo.centerYToSuperview()
        maxInfo.centerYToSuperview()
        
        minInfo.widthAnchor.constraint(equalTo: feelsLikeInfo.widthAnchor, multiplier: 10/9).isActive = true
        feelsLikeInfo.widthAnchor.constraint(equalTo: maxInfo.widthAnchor, multiplier: 9/10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func populateLabels(main: MainModel)
    {
        minInfo.info = String(Int(round(main.temp_min))) + "°"
        feelsLikeInfo.info = String(Int(round(main.feels_like))) + "°"
        maxInfo.info = String(Int(round(main.temp_max))) + "°"
    }
}
