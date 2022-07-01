//
//  SearchResultTableViewController.swift
//  MyWeather
//
//  Created by Alexandre Josien on 29/06/2022.
//

import UIKit
import CoreLocation

class SearchResultTableViewController: UITableViewController {

    var results: [CityModel]?
    var target: ViewController?
    var base: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)

        // Configure the cell...

        guard let results = results else {
            return cell
        }

        let result = results[indexPath.row]
        cell.textLabel?.text = "\(result.name) - \(result.country) \(result.state ?? "")"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        target?.locationManager.stopUpdatingLocation()
        guard let results = results else {
            return
        }

        let result = results[indexPath.row]
        target?.city = result
        target?.loadAndPopulate()
        target?.currentLocation = false
        self.dismiss(animated: true) {
            self.base?.dismiss(animated: true)
        }
    }
    
    func populate(city: String)
    {
        getGeoCoding(city: city) { cities, error in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            guard let cities = cities else {
                return
            }
            self.results = cities
            self.tableView.reloadData()
        }
    }
    

}
