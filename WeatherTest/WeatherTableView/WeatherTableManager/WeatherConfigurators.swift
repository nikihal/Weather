//
//  WeatherConfigurator.swift
//  WeatherTest
//
//  Created by Nikita on 21.11.2022.
//

import Foundation
import UIKit
 
protocol WeatherConfiguratorsProtocol: BaseConfigurator {}

final class WeatherConfigurator: WeatherConfiguratorsProtocol {
    
    var reuseId: String { String(describing: CityTableViewCell.self) }
    var weatherData: WeatherModel?
    
    func setupCell(_ cell: UIView) {
        guard let cell = cell as? CityTableViewCellProtocol,
              let weatherData = weatherData else { return }
        cell.setupCell(with: weatherData)
    }
}

final class ForecastForTheDayConfigurator: WeatherConfiguratorsProtocol {
    
    var reuseId: String { String(describing: ForecastForTheDayTableViewCell.self) }
    var wetherForecastForTheDay: [WeatherPerDay]?
    
    func setupCell(_ cell: UIView) {
        guard let cell = cell as? ForecastForTheDayTableViewCellProtocol,
              let wetherForecastForTheDay = wetherForecastForTheDay else { return }
        cell.setupCell(with: wetherForecastForTheDay)
    }
}

final class TenDayForecastConfigurator: WeatherConfiguratorsProtocol {
    
    var reuseId: String { String(describing: TenDayForecastTableViewCell.self) }
    var forecastForTenDays: [Forecast]?
    
    func setupCell(_ cell: UIView) {
        guard let cell = cell as? TenDayForecastTableViewCellProtocol,
              let forecastForTenDays = forecastForTenDays else { return }
        cell.setupCell(with: forecastForTenDays)
    }
}
