//
//  TableView+Extensions.swift
//  WeatherTest
//
//  Created by Nikita on 20.11.2022.
//

import UIKit

extension UITableView {
    
    func registerCell<T>(_:T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: String(describing: T.self))
    }
}
