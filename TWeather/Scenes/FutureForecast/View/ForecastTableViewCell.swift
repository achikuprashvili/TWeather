//
//  ForecastTableViewCell.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import SDWebImage

class ForecastTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ForecastTableViewCell"

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareUI()
    }
    
    func prepareUI() {
        dateLabel.textColor = UIColor.AppColor.normalTextColor
        descriptionLabel.textColor = UIColor.AppColor.normalTextColor
        temperatureLabel.textColor = UIColor.AppColor.headerTitleColor
        dateLabel.font = UIFont.AppFonts.sfuitTextRegular(with: 16)
        descriptionLabel.font = UIFont.AppFonts.sfuitTextRegular(with: 16)
        temperatureLabel.font = UIFont.AppFonts.sfuitTextMedium(with: 21)
        contentView.backgroundColor = UIColor.AppColor.backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with model: ForecastCellVM) {
        dateLabel.text = model.time
        descriptionLabel.text = model.description
        temperatureLabel.text = "\(model.temp)°C"
        iconImageView.sd_setImage(with: URL(string: model.icon), completed: nil)
    }
    
}
