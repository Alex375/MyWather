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

    enum PresentingMode
    {
        case details
        case `default`
    }
    
    var contextProvider = CoreDataContextProvider(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, target: nil)
    
    var presentingMode: PresentingMode = .default
    var defaultContraints: Constraints = Constraints()
    var detailsContraints: Constraints = Constraints()
    var rainOnConstraints: Constraint? = nil
    var rainOffConstrains: Constraint? = nil
    
    var lastWeather: WeatherModel?
    var location: CLLocationCoordinate2D?
    var currentLocation: Bool = true {
        didSet {
            locationButton.isHidden = currentLocation
            DispatchQueue.main.async {
                self.setUpStar()
            }
        }
    }
    var city: CityModel?
    
    let locationManager = CLLocationManager()
    
    //MARK: - UI Attributs
    lazy var temperatureLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "AvenirNext-Medium", size: 56)
        lbl.textColor = UIColor(named: "rainColor")
        lbl.adjustsFontSizeToFitWidth = true
        lbl.text = "-"
        return lbl
    }()
    
    lazy var iconView: IconView = {
        let v = IconView()
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
    
    lazy var rainGroup: RainGroup = {
        let group = RainGroup()
        return group
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
    
    lazy var otherGroup: OtherInfoGroup = {
        let group = OtherInfoGroup()
        return group
    }()
    
    lazy var chevronImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.up")
        iv.size(.init(width: 60, height: 25))
        iv.tintColor = .lightGray
        return iv
    }()
    
    lazy var locationButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "location.fill"), for: .normal)
        return btn
    }()
    
    lazy var starButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        return btn
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
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(presentSearche))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(presentSettings))
        
        layoutViews()
        setUpGestureRecognizer()
        view.backgroundColor = UIColor(named: "VCBack")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location?.coordinate else {
            let alert = UIAlertController(title: "Error", message: "Failed to get location.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.location = locValue
        loadAndPopulate()
        
        
    }
    
    
    //MARK: - Layout functions
    func layoutViews()
    {
        layoutTempLabel()
        layoutIcon()
        layoutDescrption()
        layoutRainGroup()
        layoutTemperatureGroup()
        layoutSunGroup()
        layoutWindGroup()
        layoutOtherGroup()
        layoutChevron()
        layoutLocationButton()
        layoutStarButton()
    }
    
    func layoutTempLabel()
    {
        view.addSubview(temperatureLabel)
        defaultContraints.append(temperatureLabel.centerX(to: view))
        temperatureLabel.top(to: view, view.safeAreaLayoutGuide.topAnchor)
        
        detailsContraints.append(temperatureLabel.leading(to: sunGroup, isActive: false))
        detailsContraints.append(temperatureLabel.height(50, isActive: false))
    }
    
    func layoutIcon()
    {
        view.addSubview(iconView)
        defaultContraints.append(iconView.centerX(to: view))
        defaultContraints.append(iconView.topToBottom(of: temperatureLabel, offset: 10))
        
        
        defaultContraints.append(contentsOf: iconView.size(.init(width: 190, height: 190)))
        
        
        
        detailsContraints.append(iconView.top(to: temperatureLabel, isActive: false))
        detailsContraints.append(iconView.leadingToTrailing(of: temperatureLabel, offset: 9, isActive: false))
        detailsContraints.append(contentsOf: iconView.size(.init(width: 50, height: 50), isActive: false))
    }
    
    func layoutDescrption()
    {
        view.addSubview(descrptionLabel)
        defaultContraints.append(descrptionLabel.centerX(to: view))
        defaultContraints.append(descrptionLabel.topToBottom(of: iconView, offset: 10))
        
        detailsContraints.append(descrptionLabel.leadingToTrailing(of: iconView, offset: 9, isActive: false))
        detailsContraints.append(descrptionLabel.top(to: iconView, isActive: false))
        detailsContraints.append(descrptionLabel.bottom(to: iconView, isActive: false))
    }
    
    func layoutRainGroup()
    {
        view.addSubview(rainGroup)
        view.addSubview(sunGroup)
        
        rainGroup.topToBottom(of: descrptionLabel, offset: 10)
        rainGroup.leading(to: sunGroup)
        rainGroup.trailing(to: sunGroup)
        rainOnConstraints = rainGroup.height(110, isActive: false)
        
        rainOffConstrains = rainGroup.height(0)
        rainOffConstrains?.isActive = true
        rainGroup.layer.cornerRadius = 10
    }
    
    func layoutTemperatureGroup()
    {
        view.addSubview(temperatureGroup)
        temperatureGroup.topToBottom(of: rainGroup, offset: 30)
        temperatureGroup.leading(to: view, view.safeAreaLayoutGuide.leadingAnchor, offset: 20)
        temperatureGroup.trailing(to: view, view.safeAreaLayoutGuide.trailingAnchor, offset: -20)
    }
    
    func layoutSunGroup()
    {
        
        sunGroup.topToBottom(of: temperatureGroup, offset: 20)
        sunGroup.centerXToSuperview()
        sunGroup.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4).isActive = true
    }
    
    func layoutWindGroup()
    {
        view.addSubview(windGroup)
        
        windGroup.topToBottom(of: sunGroup, offset: 20)
        windGroup.centerXToSuperview()
        windGroup.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4).isActive = true
    }
    
    func layoutOtherGroup()
    {
        view.addSubview(otherGroup)
        
        otherGroup.leading(to: windGroup)
        otherGroup.trailing(to: windGroup)
        
        detailsContraints.append(otherGroup.topToBottom(of: windGroup, offset: 10, isActive: false))
        
        defaultContraints.append(otherGroup.topToBottom(of: view))
        
        otherGroup.isHidden = true
    }
    
    
    func layoutChevron()
    {
        view.addSubview(chevronImage)
        
        chevronImage.bottom(to: view, view.safeAreaLayoutGuide.bottomAnchor, offset: -15)
        chevronImage.centerXToSuperview()
    }
    
    func layoutLocationButton()
    {
        view.addSubview(locationButton)
        locationButton.addTarget(self, action: #selector(currentLoc), for: .touchUpInside)
        locationButton.isHidden = true
        locationButton.top(to: view, view.safeAreaLayoutGuide.topAnchor, offset: 20)
        locationButton.trailing(to: view, view.safeAreaLayoutGuide.trailingAnchor, offset: -10)
        locationButton.size(.init(width: 30, height: 30))
        locationButton.layer.cornerRadius = 15
    }
    
    func layoutStarButton()
    {
        view.addSubview(starButton)
        starButton.addTarget(self, action: #selector(starTrigger), for: .touchUpInside)
        starButton.isHidden = true
        starButton.top(to: view, view.safeAreaLayoutGuide.topAnchor, offset: 20)
        starButton.leading(to: view, view.safeAreaLayoutGuide.leadingAnchor, offset: 10)
        starButton.size(.init(width: 30, height: 30))
        starButton.layer.cornerRadius = 15
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
        otherGroup.populate(main: weather.main)
        
        if let rain = weather.rain
        {
            rainGroup.isHidden = false
            rainOffConstrains?.isActive = false
            rainOnConstraints?.isActive = true
            rainGroup.populate(rain: rain)
        }
        else
        {

            rainOffConstrains?.isActive = true
            rainOnConstraints?.isActive = false
        }
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            if weather.rain == nil {
                self.rainGroup.isHidden = true
            }
        }
        

        
    }
    

    func loadAndPopulate()
    {
        if let city = city {
            self.location = CLLocationCoordinate2D(
                latitude: city.lat,
                longitude: city.lon)
        }
        guard let location = location else {
            return
        }
        getWeather(location: location) { weather in
            self.populateViews(weather: weather)
            self.lastWeather = weather
        }
    }
    
    //MARK: - Gesture recognizer
    
    func setUpGestureRecognizer()
    {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipeUp(sender: Any?)
    {
        setPresentingMode(toMode: .details, animate: true)
        let imapct = UIImpactFeedbackGenerator(style: .light)
        imapct.impactOccurred(intensity: 0.5)
    }
    
    @objc func swipeDown(sender: Any?)
    {
        setPresentingMode(toMode: .default, animate: true)
        let imapct = UIImpactFeedbackGenerator(style: .light)
        imapct.impactOccurred(intensity: 0.5)
    }
    
    
    //MARK: - Presentation mode
    func setPresentingMode(toMode mode: PresentingMode, animate: Bool)
    {
        if mode == presentingMode {
            return
        }
        
        if mode == .default {
            detailsContraints.deActivate()
            defaultContraints.activate()
            iconView.layer.cornerRadius = 95
            iconView.detailConstrains.deActivate()
            iconView.defaultConstrains.activate()
            chevronImage.image = UIImage(systemName: "chevron.up")
            windGroup.setDetails(to: false, animate: animate)
        }
        else {
            defaultContraints.deActivate()
            detailsContraints.activate()
            iconView.layer.cornerRadius = 25
            iconView.defaultConstrains.deActivate()
            iconView.detailConstrains.activate()
            chevronImage.image = UIImage(systemName: "chevron.down")
            windGroup.setDetails(to: true, animate: animate)
            otherGroup.isHidden = false
        }
        
        if animate {
            UIView.animate(withDuration: 0.6) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                if mode == .default
                {
                    self.otherGroup.isHidden = true
                }
            }
        }
        else {
            view.layoutIfNeeded()
            if mode == .default
            {
                otherGroup.isHidden = true
            }
        }
        
        
        presentingMode = mode
    }
    
    func setUpStar()
    {
        if currentLocation
        {
            starButton.isHidden = true
            return
        }
        starButton.isHidden = false
        guard let city = city else {
            return
        }

        if contextProvider.isFavouriteCity(city: city)
        {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    //MARK: - Navigation
    @objc func presentSettings(sender: Any?)
    {
        let vc = SettingsTableViewController(style: .insetGrouped)
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @objc func presentSearche(sender: Any?)
    {
        let vc = SearchTableViewController()
        vc.target = self
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @objc func currentLoc(sender: Any?)
    {
        city = nil
        location = nil
        currentLocation = true
        locationManager.startUpdatingLocation()
    }
    
    @objc func starTrigger(sender: Any?)
    {
        guard let city = city else {
            return
        }

        if contextProvider.isFavouriteCity(city: city)
        {
            contextProvider.deleteFavourite(favorite: city)
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        else
        {
            contextProvider.addFavourite(city: city)
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
    }
}

