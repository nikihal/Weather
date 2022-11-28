//
//  TenDayForecastCell.swift
//  WeatherTest
//
//  Created by Nikita on 24.11.2022.
//

import UIKit

protocol TenDayForecastTableViewCellProtocol {
    func setupCell(with forecastForTenDays: [Forecast])
}

final class TenDayForecastTableViewCell: UITableViewCell, TenDayForecastTableViewCellProtocol {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = AppTheme.Colors.lightGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(OneDayTableViewCell.self, forCellReuseIdentifier: String(describing: OneDayTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppTheme.Colors.cellBackgroundColor
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Calendar")
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AppTheme.Colors.lightGray
        label.font = AppTheme.Fonts.SFRegular(14)
        label.text = "10-DAY FORECAST"
        label.numberOfLines = 1
        label.heightAnchor.constraint(equalToConstant: 17).isActive = true
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [calendarImageView, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [horizontalStackView, separatorView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppTheme.Colors.lightGray
        return view
    }()
    
    private var forecastForTenDays: [Forecast] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutIfNeeded() {
        backgroundColor = .clear
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(backView)
        backView.addSubview(horizontalStackView)
        backView.addSubview(verticalStackView)
        backView.addSubview(tableView)
        
        setupBackViewConstraints()
        setupHorizontalStackViewConstraints()
        setupVericalStackViewConstraints()
        setupTableViewConstraints()
    }
    
    private func setupBackViewConstraints() {
        self.backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        self.backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        self.backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        self.backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func setupHorizontalStackViewConstraints() {
        calendarImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        calendarImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        horizontalStackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15).isActive = true
        horizontalStackView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setupVericalStackViewConstraints() {
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        horizontalStackView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15).isActive = true
    }
    
    private func setupTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -15).isActive = true
        tableView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15).isActive = true
    }
    
    func setupCell(with forecastForTenDays: [Forecast]) {
        self.forecastForTenDays = forecastForTenDays
    }
    
}

extension TenDayForecastTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastForTenDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OneDayTableViewCell.self), for: indexPath) as? OneDayTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        cell.setupCell(with: forecastForTenDays[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        47
    }
    
}
