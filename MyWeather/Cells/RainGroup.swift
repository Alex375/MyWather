//
//  RainGroup.swift
//  MyWeather
//
//  Created by Alexandre Josien on 26/06/2022.
//

import UIKit

class RainGroup: UIView {

    lazy var image: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "cloud.rain.fill")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    lazy var oneH: TempLabel = {
        let lbl = TempLabel(name: "main.lastHour".localized)
        lbl.info = "-"
        return lbl
    }()
    
    lazy var threeH: TempLabel = {
        let lbl = TempLabel(name: "main.last3Hour".localized)
        lbl.info = "-"
        return lbl
    }()
    
    init()
    {
        super.init(frame: .zero)
        
        backgroundColor = UIColor(named: "rainBackground")
        
        addSubview(image)
        image.top(to: self, offset: 10)
        image.leading(to: self, offset: 10)
        image.size(.init(width: 33, height: 38))
        
        addSubview(oneH)
        oneH.leadingToTrailing(of: image, offset: 6)
        oneH.centerYToSuperview()
        
        addSubview(threeH)
        threeH.leadingToTrailing(of: oneH)
        threeH.centerYToSuperview()
        threeH.trailing(to: self, offset: -49)
        
        oneH.widthAnchor.constraint(equalTo: threeH.widthAnchor, multiplier: 1).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(rain: RainModel)
    {
        oneH.info = String(Int(round(rain.oneH))) + "mm"
        if let three = rain.threeH {
            threeH.info = String(Int(round(three))) + "mm"
        }
    }
    
}
