//
//  CoreDataContextProvider.swift
//  MyWeather
//
//  Created by Alexandre Josien on 01/07/2022.
//

import Foundation
import CoreData
import UIKit
import CoreLocation


class CoreDataContextProvider
{
    var context: NSManagedObjectContext
    var target: UIViewController?
    
    init(context: NSManagedObjectContext, target: ViewController?)
    {
        self.context = context
        self.target = target
    }
    
    func getFavorites() -> [Favorite]
    {
        do {
            return try context.fetch(Favorite.fetchRequest())
        }
        catch let error  {
            let alert = UIAlertController(title: "Unable to get favorite", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            target?.present(alert, animated: true)
        }
        return []
    }
    
    func deleteFavourite(favorite: Favorite)
    {
        context.delete(favorite)
        do {
            try context.save()
        }
        catch let error {
            let alert = UIAlertController(title: "Unable to delete favorite", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            target?.present(alert, animated: true)
        }
    }

    func deleteFavourite(favorite: CityModel)
    {
        let fav = self.getFavorites()
        for f in fav {
            if f.name == favorite.name
                && f.lat == favorite.lat
                && f.lon == favorite.lon
                && f.country == favorite.country
                && f.state == favorite.state
            {
                self.deleteFavourite(favorite: f)
            }
        }
    }
    
    func addFavourite(city: CityModel)
    {
        let newItem = Favorite(context: context)
        newItem.lon = city.lon
        newItem.lat = city.lat
        newItem.name = city.name
        newItem.country = city.country
        newItem.state = city.state
        
        do {
            try context.save()
        }
        catch let error {
            let alert = UIAlertController(title: "Unable to add favorite", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            target?.present(alert, animated: true)
        }
    }
    
    func isFavouriteCity(city: CityModel) -> Bool
    {
        let fav = self.getFavorites()
        for f in fav {
            if f.name == city.name
                && f.lat == city.lat
                && f.lon == city.lon
                && f.country == city.country
                && f.state == city.state
            {
                return true
            }
        }
        return false
    }
}
