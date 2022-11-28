//
//  AppTheme.swift
//  WeatherTest
//
//  Created by Nikita on 20.11.2022.
//

import UIKit

public enum AppTheme {
    enum Colors {
        public static let lightGray = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        public static let cellBackgroundColor = UIColor(red: 0.235, green: 0.306, blue: 0.396, alpha: 0.6)
    }
    
    enum Fonts {
        public static func SFRegular(_ size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
        }
    }
}
