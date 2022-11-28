//
//  DataManager.swift
//  WeatherTest
//
//  Created by Nikita on 25.11.2022.
//

import Foundation


final class DataManager {
    
     func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func parse(jsonData: Data, completion: @escaping ((WeatherModel?) -> Void)) {
        do {
            let decodedData = try JSONDecoder().decode(WeatherModel.self,
                                                       from: jsonData)
            completion(decodedData)
        } catch {
            print("decode error")
        }
    }
}
