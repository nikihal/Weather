//
//  WeatherViewController.swift
//  WeatherTest
//
//  Created by Nikita on 20.11.2022.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    var tableView = UITableView()
    var presenter: WeatherPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WeatherPresenter(view: self)
        assignBackground()
        setupTable()
        presenter?.attachTableView(tableView)
        presenter?.setupMockData()
    }
    
}

extension WeatherViewController: PresenterView {
    
}

private extension WeatherViewController {
    
    func setupTable() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.pin(to: view)
    }
    
    func assignBackground(){
        let background = UIImage(named: "background")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
}
