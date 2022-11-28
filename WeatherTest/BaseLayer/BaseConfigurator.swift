//
//  BaseConfigurator.swift
//  WeatherTest
//
//  Created by Nikita on 21.11.2022.
//

import Foundation
import UIKit

protocol BaseConfigurator {
    var reuseId: String { get }
    func setupCell(_ cell: UIView)
}
