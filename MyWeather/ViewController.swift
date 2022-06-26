//
//  ViewController.swift
//  MyWeather
//
//  Created by Alexandre Josien on 25/06/2022.
//

import UIKit
import CoreLocation
import TinyConstraints

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    //MARK: - UI Attributs
    lazy var temperatureLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-Medium", size: 56)
        lbl.textColor = UIColor(named: "rainColor")
        lbl.text = "-"
        return lbl
    }()
    
    lazy var iconView: IconView = {
        let v = IconView()
        v.size(.init(width: 190, height: 190))
        v.layer.cornerRadius = 95
        return v
    }()
    
    lazy var descrptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext", size: 24)
        lbl.text = "-"
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    lazy var temperatureGroup: TemperatureGroup = {
        let group = TemperatureGroup()
        return group
    }()
    
    lazy var sunGroup: SunGroup = {
        let group = SunGroup()
        return group
    }()
    
    lazy var windGroup: WindGroup = {
        let group = WindGroup()
        return group
    }()
    
    lazy var chevronImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.up")
        iv.size(.init(width: 40, height: 15))
        iv.tintColor = .lightGray
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Location not enabled.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        
        layoutViews()
        view.backgroundColor = .white
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location?.coordinate else {
            let alert = UIAlertController(title: "Error", message: "Failed to get location.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        loadAndPopulate(location: locValue)
        
        
    }
    
    
    //MARK: - Layout functions
    func layoutViews()
    {
        layoutTempLabel()
        layoutIcon()
        layoutDescrption()
        layoutTemperatureGroup()
        layoutSunGroup()
        layoutWindGroup()
        layoutChevron()
    }
    
    func layoutTempLabel()
    {
        view.addSubview(temperatureLabel)
        temperatureLabel.centerX(to: view)
        temperatureLabel.top(to: view, view.safeAreaLayoutGuide.topAnchor)
    }
    
    func layoutIcon()
    {
        view.addSubview(iconView)
        iconView.centerX(to: view)
        iconView.topToBottom(of: temperatureLabel, offset: 10)
    }
    
    func layoutDescrption()
    {
        view.addSubview(descrptionLabel)
        descrptionLabel.centerX(to: view)
        descrptionLabel.topToBottom(of: iconView, offset: 10)
    }
    
    func layoutTemperatureGroup()
    {
        view.addSubview(temperatureGroup)
        temperatureGroup.topToBottom(of: descrptionLabel, offset: 30)
        temperatureGroup.leading(to: view, view.safeAreaLayoutGuide.leadingAnchor, offset: 20)
        temperatureGroup.trailing(to: view, view.safeAreaLayoutGuide.trailingAnchor, offset: -20)
    }
    
    func layoutSunGroup()
    {
        view.addSubview(sunGroup)
        
        sunGroup.top(to: temperatureGroup, offset: 20)
        sunGroup.leading(to: view, view.safeAreaLayoutGuide.leadingAnchor, offset: 30)
        sunGroup.trailing(to: view, view.safeAreaLayoutGuide.trailingAnchor, offset: -30)
    }
    
    func layoutWindGroup()
    {
        view.addSubview(windGroup)
        
        windGroup.top(to: sunGroup, offset: 20)
        windGroup.leading(to: view, view.safeAreaLayoutGuide.leadingAnchor, offset: 30)
        windGroup.trailing(to: view, view.safeAreaLayoutGuide.trailingAnchor, offset: -30)
    }
    
    func layoutChevron()
    {
        view.addSubview(chevronImage)
        
        chevronImage.bottom(to: view, view.safeAreaLayoutGuide.bottomAnchor, offset: 20)
        chevronImage.centerXToSuperview()
    }
    
    //MARK: - Poulating methods
    func populateViews(weather: WeatherModel)
    {
        navigationItem.title = weather.name
        temperatureLabel.text = String(Int(round(weather.main.temp))) + "°"
        iconView.setImage(apiName: weather.weather[0].icon)
        descrptionLabel.text = String(weather.weather[0].description)
        temperatureGroup.populateLabels(main: weather.main)
        sunGroup.populateLabels(
            sunrise: weather.sys.sunrise,
            sunset: weather.sys.sunset)
        windGroup.populate(wind: weather.wind)
        
    }

    func loadAndPopulate(location: CLLocationCoordinate2D)
    {
        getWeather(location: location) { weather in
            self.populateViews(weather: weather)
        }
    }
    
}

