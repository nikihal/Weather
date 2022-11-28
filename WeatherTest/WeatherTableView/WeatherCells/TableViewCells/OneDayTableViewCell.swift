//
//  OneDayTableViewCell.swift
//  WeatherTest
//
//  Created by Nikita on 24.11.2022.
//

import UIKit

enum WeatherType: String {
    case cloud, snow
}

protocol OneDayTableViewCellProtocol {
    func setupCell(with dayForecast: Forecast)
}

final class OneDayTableViewCell: UITableViewCell, OneDayTableViewCellProtocol {

    private lazy var dayLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = AppTheme.Fonts.SFRegular(18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nightTempLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = AppTheme.Colors.lightGray
        label.font = AppTheme.Fonts.SFRegular(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dayTempLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = AppTheme.Fonts.SFRegular(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dayLabel, weatherImageView, nightTempLabel, dayTempLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 70
        return stackView
    }()
   
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        contentView.addSubview(horizontalStackView)
        setupHorizontalStackViewConstraints()
    }
    
    private func setupHorizontalStackViewConstraints() {
        dayLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        nightTempLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dayTempLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func setupCell(with dayForecast: Forecast) {
        let day = dayForecast.date.prefix(2)
        dayLabel.text = "\(day)"
        nightTempLabel.text = "\(dayForecast.minTemperature)"
        dayTempLabel.text = "\(dayForecast.maxTemperature)"
        
        let weatherType = WeatherType(rawValue: dayForecast.weatherType)
        switch weatherType {
        case .cloud:
            weatherImageView.image = UIImage(named: "Cloud")
        case .snow:
            weatherImageView.image = UIImage(named: "Snow")
        case .none:
            break
        }
    }
    
}
