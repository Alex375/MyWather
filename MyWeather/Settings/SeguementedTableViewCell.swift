//
//  SeguementedTableViewCell.swift
//  MyWeather
//
//  Created by Alexandre Josien on 27/06/2022.
//

import UIKit
import TinyConstraints

class SeguementedTableViewCell: UITableViewCell {

    lazy var control: UISegmentedControl = {
        let c = UISegmentedControl()
        return c
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(control)
        control.edges(to: contentView, insets: .init(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
