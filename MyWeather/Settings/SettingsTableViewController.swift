//
//  SettingsTableViewController.swift
//  MyWeather
//
//  Created by Alexandre Josien on 27/06/2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        tableView.register(SeguementedTableViewCell.self, forCellReuseIdentifier: "segumented")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0: return 2
        default: return 0
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "segumented", for: indexPath) as! SeguementedTableViewCell

        // Configure the cell...
        if indexPath.row == 0
        {
            cell.control.insertSegment(withTitle: "Celsius", at: 0, animated: false)
            cell.control.insertSegment(withTitle: "Fahrenheit", at: 1, animated: false)
            cell.control.insertSegment(withTitle: "Kelvin", at: 2, animated: false)
        }
        if indexPath.row == 1
        {
            cell.control.insertSegment(withTitle: "Meters/sec", at: 0, animated: false)
            cell.control.insertSegment(withTitle: "mph", at: 1, animated: false)
            cell.control.insertSegment(withTitle: "kmh", at: 2, animated: false)
            cell.control.insertSegment(withTitle: "Knots", at: 3, animated: false)
            
        }
        

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section
        {
        case 0: return "Units"
        default: return nil
        }
    }

    //MARK: - Methods
    @objc func close(sender: Any?)
    {
        self.dismiss(animated: true)
    }

}
