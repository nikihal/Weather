//
//  ForecastForTheDayTableViewCell.swift
//  WeatherTest
//
//  Created by Nikita on 21.11.2022.
//

import UIKit

protocol ForecastForTheDayTableViewCellProtocol {
    func setupCell(with wetherForecastForTheDay: [WeatherPerDay])
}

final class ForecastForTheDayTableViewCell: UITableViewCell, ForecastForTheDayTableViewCellProtocol {

    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppTheme.Colors.cellBackgroundColor
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, separatorView, collectionView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = AppTheme.Fonts.SFRegular(14)
        label.text = "Облачная погода до конца дня. Порывы ветра до 25 км/ч."
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 36).isActive = true
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppTheme.Colors.lightGray
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.insetsLayoutMarginsFromSafeArea = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(WeatherCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: WeatherCollectionViewCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
    
    private var wetherForecastForTheDay: [WeatherPerDay] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(with wetherForecastForTheDay: [WeatherPerDay]) {
        self.wetherForecastForTheDay = wetherForecastForTheDay
    }
    
    private func setupView() {
        contentView.addSubview(backView)
        backView.addSubview(descriptionStackView)
        
        setupBackViewConstraints()
        setupVericalStackViewConstraints()
    }
    
    private func setupBackViewConstraints() {
        self.backView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        self.backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        self.backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        self.backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func setupVericalStackViewConstraints() {
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        collectionView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        
        descriptionStackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15).isActive = true
        descriptionStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15).isActive = true
        descriptionStackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -15).isActive = true
        descriptionStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15).isActive = true
    }
   
}

extension ForecastForTheDayTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        wetherForecastForTheDay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WeatherCollectionViewCell.self), for: indexPath) as? WeatherCollectionViewCellProtocol else { return UICollectionViewCell() }
        cell.setupCell(with: wetherForecastForTheDay[indexPath.row])
        
        guard let cell = cell as? WeatherCollectionViewCell else { return UICollectionViewCell() }
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        let oneDay = wetherForecastForTheDay[indexPath.item]
        if oneDay.sunset != nil {
            label.text = "Заход солнца"
            label.sizeToFit()
            return CGSize(width: label.frame.width, height: 90)
        } else {
            label.text = oneDay.temperature
            label.sizeToFit()
            return CGSize(width: label.frame.width + 20, height: 90)
        }
    }
}
