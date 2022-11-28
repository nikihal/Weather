//
//  PreferencesCollectionViewCell.swift
//  music
//
//  Created by Егор Евсеенко on 2.10.21.
//

import UIKit

protocol WeatherCollectionViewCellProtocol {
    func setupCell(with forecatForTheDay: WeatherPerDay)
}

class WeatherCollectionViewCell: UICollectionViewCell, WeatherCollectionViewCellProtocol {
    
    private lazy var hourLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = AppTheme.Fonts.SFRegular(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = AppTheme.Fonts.SFRegular(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherView: UIView = {
        var imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Cloud")
        return imageView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [hourLabel, weatherView, tempLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setupView()
    }
    
    func setupView() {
        contentView.addSubview(verticalStackView)
        weatherView.addSubview(weatherImageView)
        setupVericalStackViewConstraints()
    }
    
    private func setupVericalStackViewConstraints() {
        hourLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        tempLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        weatherView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        weatherImageView.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor).isActive = true
        weatherImageView.centerYAnchor.constraint(equalTo: weatherView.centerYAnchor).isActive = true
        
        verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func setupCell(with forecatForTheDay: WeatherPerDay) {
        hourLabel.text = forecatForTheDay.timestamp
        tempLabel.text = forecatForTheDay.temperature
        if forecatForTheDay.sunset != nil, forecatForTheDay.sunset == true {
            tempLabel.text = "Заход солнца"
            weatherImageView.image = UIImage(named: "Sunset")
        }
    }
    
}

