//
//  CityTableViewCell.swift
//  WeatherTest
//
//  Created by Nikita on 20.11.2022.
//

import UIKit

protocol CityTableViewCellProtocol {
    func setupCell(with weatherData: WeatherModel)
}

class CityTableViewCell: UITableViewCell, CityTableViewCellProtocol {
    
    private var degreesLabel = UILabel()
    private var separatorView = UIView()
    private var cityNameLabel = UILabel()
    private var weatherDescriptionLabel = UILabel()
    private var horizontalStackView: UIStackView!
    private var verticalStackView: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupLabels()
        setupView()
        setupHorizontalStackView()
        setupVericalStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(with weatherData: WeatherModel) {
        cityNameLabel.text = weatherData.city
    }
    
    private func setupLabels() {
        degreesLabel.textColor = AppTheme.Colors.lightGray
        degreesLabel.font = AppTheme.Fonts.SFRegular(16)
        degreesLabel.text = "-4"
        degreesLabel.textAlignment = .center
        degreesLabel.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        
        weatherDescriptionLabel.textColor = AppTheme.Colors.lightGray
        weatherDescriptionLabel.font = AppTheme.Fonts.SFRegular(16)
        weatherDescriptionLabel.text = "Облачно"
        weatherDescriptionLabel.textAlignment = .center
        weatherDescriptionLabel.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
        
        cityNameLabel.textColor = .white
        cityNameLabel.font = AppTheme.Fonts.SFRegular(30)
        cityNameLabel.textAlignment = .center
    }
    
    private func setupView() {
        separatorView = UIView()
        separatorView.backgroundColor = AppTheme.Colors.lightGray
        separatorView.heightAnchor.constraint(equalToConstant: 19.0).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 1.0).isActive = true
    }
    
    private func setupHorizontalStackView() {
        horizontalStackView = UIStackView(arrangedSubviews: [degreesLabel, separatorView, weatherDescriptionLabel])
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 5
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
       
        addSubview(horizontalStackView)
    }
    
    private func setupVericalStackView() {
        verticalStackView = UIStackView(arrangedSubviews: [cityNameLabel, horizontalStackView])
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 5
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(verticalStackView)
        
        verticalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        verticalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}
