//
//  TempLabel.swift
//  MyWeather
//
//  Created by Alexandre Josien on 26/06/2022.
//

import UIKit
import TinyConstraints

class TempLabel: UIView {

    enum type {
        case Big
        case Default
    }
    
    
    
    lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    lazy var infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-DemiBold", size: 29)
        lbl.textColor = UIColor(named: "rainColor")
        lbl.text = "-"
        return lbl
    }()
    
    
    var title: String? {
        get {
            return nameLabel.text
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    var info: String? {
        get {
            return infoLabel.text
        }
        set {
            infoLabel.text = newValue
        }
    }
    
    
    init(name: String)
    {
        super.init(frame: .zero)
        
        nameLabel.text = name
        
        addSubview(nameLabel)
        addSubview(infoLabel)
        
        nameLabel.top(to: self)
        
        infoLabel.centerXToSuperview()
        nameLabel.leading(to: infoLabel)
        
        infoLabel.top(to: nameLabel, nameLabel.bottomAnchor, offset: 5)
        infoLabel.bottom(to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setType(_ type: type)
    {
        if type == .Default
        {
            infoLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 29)
        }
        else
        {
            infoLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 40)
        }
    }
    
}
