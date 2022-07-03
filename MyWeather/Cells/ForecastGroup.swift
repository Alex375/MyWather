//
//  ForecastGroup.swift
//  MyWeather
//
//  Created by Alexandre Josien on 03/07/2022.
//

import UIKit

class ForecastGroup: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var forecast: ForecastModel?
    let ids = [WeatherCVCell.id, RainCVCell.id, WindCVCell.id]

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.estimatedItemSize = .init(width: 50, height: 100)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(WeatherCVCell.self, forCellWithReuseIdentifier: WeatherCVCell.id)
        cv.register(RainCVCell.self, forCellWithReuseIdentifier: RainCVCell.id)
        cv.register(WindCVCell.self, forCellWithReuseIdentifier: WindCVCell.id)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    
    lazy var modeController: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Weather", "Rain", "Wind"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(modeChanged), for: .valueChanged)
        return sc
    }()
    
    init()
    {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.380495958, green: 0.5326656283, blue: 0.750397673, alpha: 0.7479746293)
        clipsToBounds = true
        addSubview(collectionView)
        addSubview(modeController)
        modeController.bottom(to: self, offset: -5)
        modeController.leading(to: self, offset: 5)
        modeController.trailing(to: self, offset: -5)
        modeController.height(30)
        
        collectionView.top(to: self, offset: 10)
        collectionView.bottomToTop(of: modeController, offset: -5)
        collectionView.leading(to: self)
        collectionView.trailing(to: self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast?.cnt ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ids[modeController.selectedSegmentIndex], for: indexPath) as! ForecastCollectionViewCell
        
        guard let forecast = forecast else {
            return cell
        }

        
        cell.populate(weather: forecast.list[indexPath.item], offset: forecast.city.timezone)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: 60)
    }
    
    func populate(forecast: ForecastModel)
    {
        self.forecast = forecast
        collectionView.reloadData()
    }
    
    @objc func modeChanged(sender: Any?)
    {
        collectionView.reloadData()
    }
    
}

