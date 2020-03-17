//
//  WeatherItemView.swift
//  TWeather
//
//  Created by Archil on 3/17/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import SDWebImage

class WeatherItemView: UIView {

    var image: UIImageView = UIImageView()
    var title: UILabel = UILabel()
    
    init(weatherItem: WeatherItem) {
        super.init(frame: .zero)
        setupLayout()
        config(with: weatherItem)
    }
    
    func config(with model: WeatherItem) {
        image.image = model.icon
        title.text = model.value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(3)).isActive = true
        image.widthAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        image.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: CGFloat(3)).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        title.textAlignment = .center
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        title.textColor = UIColor.AppColor.normalTextColor
        title.font = UIFont.AppFonts.sfuitTextRegular(with: 16)
        title.textAlignment = .center
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.backgroundColor = UIColor.AppColor.backgroundColor
        
    }
}

enum WeatherItem {
    case wind(value: String)
    case humidity(value: String)
    case pressure(value: String)
    case degree(value: String)
    case sunset(value: String)
    case sunrise(value: String)
    
    var icon: UIImage {
        switch self {
        case .wind:
            return UIImage(named: "wind")!
        case .humidity:
            return UIImage(named: "humidity")!
        case .pressure:
            return UIImage(named: "pressure")!
        case .degree:
            return UIImage(named: "compas")!
        case .sunset:
            return UIImage(named: "sunset")!
        case .sunrise:
            return UIImage(named: "sunrise")!
        }
    }
    
    var value: String {
        switch self {
        case .wind(let value):
            return value + " km/h"
        case .humidity(let value):
            return value + "%"
        case .pressure(let value):
            return value + "hPa"
        case .degree(let value):
            return value
        case .sunset(let value):
            return value
        case .sunrise(let value):
            return value
        }
    }
}
