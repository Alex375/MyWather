//
//  StringExension.swift
//  MyWeather
//
//  Created by Alexandre Josien on 01/07/2022.
//

import Foundation

import Foundation


extension String
{
    /**
     Function that return the localized string.
     - Returns: The localized string of self.
     - Remark: If User default for debugdstring is true it will return self.
     */
    func localizeString() -> String
    {
        return NSLocalizedString(self, comment: "")
            
    }
    
    /**
     Localized version of string.
     - Remark: If User default for debugdstring is true `localized` = self
     */
    var localized: String { self.localizeString() }
}
