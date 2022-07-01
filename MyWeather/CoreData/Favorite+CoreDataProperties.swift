//
//  Favorite+CoreDataProperties.swift
//  MyWeather
//
//  Created by Alexandre Josien on 01/07/2022.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var state: String?

}

extension Favorite : Identifiable {

}
