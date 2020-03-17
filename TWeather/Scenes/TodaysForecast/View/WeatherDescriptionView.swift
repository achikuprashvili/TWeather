//
//  WeatherDetail.swift
//  TWeather
//
//  Created by Archil on 3/17/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import SDWebImage

class WeatherDescriptionView: UIView {
    var image: UIImageView = UIImageView()
    var title: UILabel = UILabel()
    var descriptionLabel: UILabel = UILabel()
    
    init(model: WeatherDescriptionVM) {
        super.init(frame: .zero)
        setupLayout()
        config(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with model: WeatherDescriptionVM) {
        image.sd_setImage(with: URL(string: model.imageUrl), completed: nil)
        descriptionLabel.text = model.description
        title.text = model.title
    }
    
    func setupLayout() {
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(50)).isActive = true
        image.widthAnchor.constraint(equalToConstant: CGFloat(90)).isActive = true
        image.heightAnchor.constraint(equalToConstant: CGFloat(90)).isActive = true
        
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        title.textColor = UIColor.AppColor.headerTitleColor
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: CGFloat(8)).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        title.textAlignment = .center
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)
        descriptionLabel.textColor = UIColor.AppColor.normalTextColor
        descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: CGFloat(8)).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        descriptionLabel.textAlignment = .center
        
        self.backgroundColor = UIColor.AppColor.backgroundColor
        
    }
}

struct WeatherDescriptionVM {
    let imageUrl: String
    let title: String
    let description: String
}
