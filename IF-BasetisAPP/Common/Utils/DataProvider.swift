//
//  DataProvider.swift
//  IF-BasetisAPP
//
//  Created by Nekane Pardo on 29/09/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation

class DataProvider {
    
    /// loadLocalJson reads a .json file saved in the project, places in array (descripted in codable Cinema Model) and returns it.
    /// - Parameter name: file name
    /// - Returns: Cinema Array, with Name, Latitude and Longitude properties
    func loadLocalJson(_ name: String) -> [Cinema] {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else { return [Cinema]() }
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            let cinemas = try JSONDecoder().decode([Cinema].self, from: jsonData)
            return cinemas
        } catch {
            return [Cinema]()
        }
    }
}
