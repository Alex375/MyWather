//
//  SearchTableViewController.swift
//  MyWeather
//
//  Created by Alexandre Josien on 29/06/2022.
//

import UIKit
import CoreData
import CoreLocation

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    var target: ViewController?
    var contextProvider = CoreDataContextProvider(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, target: nil)
        
    private var favourites: [Favorite] = []
    
    private lazy var persistentContainer: NSPersistentContainer = {
            NSPersistentContainer(name: "Model")
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        contextProvider.target = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        let resultVC = SearchResultTableViewController()
        resultVC.target = target
        resultVC.base = self
        let searchController = UISearchController(searchResultsController: resultVC)
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.title = "Search a city"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        
        favourites = contextProvider.getFavorites()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = favourites[indexPath.row].name
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        target?.locationManager.stopUpdatingLocation()
        let fav = favourites[indexPath.row]
        let city = CityModel(name: fav.name!, lat: fav.lat, lon: fav.lon, country: fav.country!, state: fav.state)
        target?.city = city
        target?.loadAndPopulate()
        target?.currentLocation = false
        dismiss(animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = navigationItem.searchController?.searchResultsController as! SearchResultTableViewController
        let text = searchBar.text
        guard let text = text else {
            return
        }
        vc.populate(city: text)
        
    }

    @objc func close(sender: Any?)
    {
        dismiss(animated: true)
    }
    
    
}


