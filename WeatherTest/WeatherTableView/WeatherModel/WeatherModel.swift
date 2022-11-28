//
//  WeatherModel.swift
//  WeatherTest
//
//  Created by Nikita on 20.11.2022.
//

import Foundation

struct WeatherModel: Codable {
    let city, temperature, weatherDescription: String
    let weatherPerDay: [WeatherPerDay]?
    let forecast: [Forecast]?

    enum CodingKeys: String, CodingKey {
        case city, temperature
        case weatherDescription = "description"
        case weatherPerDay = "weather_per_day"
        case forecast
    }
}

struct Forecast: Codable {
    let date: String
    let minTemperature, maxTemperature: Int
    let weatherType: String

    enum CodingKeys: String, CodingKey {
        case date
        case minTemperature = "min_temperature"
        case maxTemperature = "max_temperature"
        case weatherType = "weather_type"
    }
}


struct WeatherPerDay: Codable {
    let timestamp, weatherType, temperature: String
    let sunset: Bool?

    enum CodingKeys: String, CodingKey {
        case timestamp
        case weatherType = "weather_type"
        case temperature, sunset
    }
}
