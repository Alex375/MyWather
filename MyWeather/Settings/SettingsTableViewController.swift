//
//  SettingsTableViewController.swift
//  MyWeather
//
//  Created by Alexandre Josien on 27/06/2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    var target: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        
        navigationItem.title = "settings.title".localized
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
            cell.control.selectedSegmentIndex = UserDefaults
                .standard
                .integer(forKey: Settings.tempUnit.rawValue)
            cell.control.addTarget(
                self,
                action: #selector(tempChanged),
                for: .valueChanged)
        }
        if indexPath.row == 1
        {
            cell.control.insertSegment(withTitle: "mps.full".localized, at: 0, animated: false)
            cell.control.insertSegment(withTitle: "mph.full".localized, at: 1, animated: false)
            cell.control.insertSegment(withTitle: "kph.full".localized, at: 2, animated: false)
            cell.control.insertSegment(withTitle: "knots.full".localized, at: 3, animated: false)
            cell.control.selectedSegmentIndex = UserDefaults
                .standard
                .integer(forKey: Settings.speedUnit.rawValue)
            cell.control.addTarget(
                self,
                action: #selector(speedChanged),
                for: .valueChanged)
        }
        

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section
        {
        case 0: return "setting.units".localized
        default: return nil
        }
    }

    //MARK: - Methods
    @objc func close(sender: Any?)
    {
        self.dismiss(animated: true)
    }
    
    @objc func speedChanged(sender: UISegmentedControl)
    {
        UserDefaults
            .standard
            .set(sender.selectedSegmentIndex, forKey: Settings.speedUnit.rawValue)
        guard let target = target else {
            return
        }
        target.loadAndPopulate()
    }
    
    
    @objc func tempChanged(sender: UISegmentedControl)
    {
        UserDefaults
            .standard
            .set(sender.selectedSegmentIndex, forKey: Settings.tempUnit.rawValue)
        guard let target = target else {
            return
        }
        target.loadAndPopulate()
    }

}
