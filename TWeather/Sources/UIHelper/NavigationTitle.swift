//
//  NavigationTitle.swift
//  TWeather
//
//  Created by Archil on 3/17/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class NavigationTitleView: UIView {
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColor.headerTitleColor
        label.font = UIFont.AppFonts.sfuitTextMedium(with: 21)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    convenience init(title: String) {
        self.init(frame: CGRect.zero)
        self.title.text = title
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        heightAnchor.constraint(equalToConstant:  44).isActive = true
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
    }
}
