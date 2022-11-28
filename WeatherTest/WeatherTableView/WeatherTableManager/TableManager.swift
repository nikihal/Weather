//
//  TableManager.swift
//  WeatherTest
//
//  Created by Nikita on 20.11.2022.
//

enum RowHeight: Int {
    case firstCell, secondCell, thirdCell
}

import UIKit

protocol WeatherTableMangerProtocol {
    func attachTable(_ tableView: UITableView)
    func setDataToTableView(with weatherData: WeatherModel)
}

final class WeatherTableManger: NSObject, WeatherTableMangerProtocol {
    
    private weak var tableView: UITableView?
    private var weatherData: [WeatherModel] = []
    private var configurators: [WeatherConfiguratorsProtocol] = []
    private let cellSpacingHeight: CGFloat = 10
    
    func attachTable(_ tableView: UITableView) {
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 125
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: String(describing: CityTableViewCell.self))
        tableView.register(ForecastForTheDayTableViewCell.self, forCellReuseIdentifier: String(describing: ForecastForTheDayTableViewCell.self))
        tableView.register(TenDayForecastTableViewCell.self, forCellReuseIdentifier: String(describing: TenDayForecastTableViewCell.self))
        self.tableView = tableView
    }

}

extension WeatherTableManger: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        configurators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = configurators[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: configurator.reuseId, for: indexPath)
        configurator.setupCell(cell)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        let cellsHeight = RowHeight(rawValue: indexPath.row)
        switch cellsHeight {
        case .firstCell:
            return 90
        case .secondCell:
            return 200
        case .thirdCell:
            return 490
        case .none:
            return 0
        }
    }
    
}

extension WeatherTableManger {
    
    func setDataToTableView(with weatherData: WeatherModel) {
        var output: [WeatherConfiguratorsProtocol] = []
        output.append(createCityDataConfigurator(weatherData: weatherData))
        if let wetherForecastForTheDay = weatherData.weatherPerDay {
            output.append(createForecastForTheDayConfigurator(wetherForecastForTheDay: wetherForecastForTheDay))
        }
        if let forecastForTenDays = weatherData.forecast {
            output.append(createTenDayForecastConfigurator(forecastForTenDays: forecastForTenDays))
        }
        configurators = output
        tableView?.reloadData()
    }
    
    private func createCityDataConfigurator(weatherData: WeatherModel) -> WeatherConfiguratorsProtocol {
        let configurator = WeatherConfigurator()
        configurator.weatherData = weatherData
        return configurator
    }
    
    private func createForecastForTheDayConfigurator(wetherForecastForTheDay: [WeatherPerDay]) -> WeatherConfiguratorsProtocol {
        let configurator = ForecastForTheDayConfigurator()
        configurator.wetherForecastForTheDay = wetherForecastForTheDay
        return configurator
    }
    
    private func createTenDayForecastConfigurator(forecastForTenDays: [Forecast]) -> WeatherConfiguratorsProtocol {
        let configurator = TenDayForecastConfigurator()
        configurator.forecastForTenDays = forecastForTenDays
        return configurator
    }
    
}
