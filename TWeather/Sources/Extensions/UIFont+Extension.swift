//
//  UIFont+Extension.swift
//  TWeather
//
//  Created by Archil on 3/17/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

extension UIFont {
    
    struct AppFonts {
        static let SFUITextRegular = ".SFUIText"
        static let SFUITextMedium = ".SFUIText-Medium"
        
        static func sfuitTextRegular(with size: CGFloat) -> UIFont {
            return UIFont(name: UIFont.AppFonts.SFUITextRegular, size: size)!
        }
        
        static func sfuitTextMedium(with size: CGFloat) -> UIFont {
            return UIFont(name: UIFont.AppFonts.SFUITextMedium, size: size)!
        }
    }
}
