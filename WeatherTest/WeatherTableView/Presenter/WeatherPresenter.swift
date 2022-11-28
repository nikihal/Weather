//
//  Pesenter.swift
//  WeatherTest
//
//  Created by Nikita on 22.11.2022.
//

import UIKit

protocol PresenterView: AnyObject {
    
}

class WeatherPresenter {
    
    private let dataManager = DataManager()
    weak var view: PresenterView?
    let tableManager: WeatherTableMangerProtocol = WeatherTableManger()
    
    init(view: PresenterView) {
        self.view = view
    }
    
    func attachTableView(_ table: UITableView) {
        tableManager.attachTable(table)
    }
    
    func setupMockData() {
        guard let data = dataManager.readLocalFile(forName: "TestTaskJSON") else { return }
        dataManager.parse(jsonData: data) { [ weak self ] weatherModel in
            guard let self,
                  let weatherModel else { return }
            self.tableManager.setDataToTableView(with: weatherModel)
        }
    }
}
