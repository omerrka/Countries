//
//  CountiresData.swift
//  Countries
//
//  Created by Ömer Karabulut on 20.03.2023.
//

import Foundation

struct CountriesData: Codable {
    let code: String
    let currencyCodes: [String]
    let name, wikiDataID: String

    enum CodingKeys: String, CodingKey {
        case code, currencyCodes, name
        case wikiDataID = "wikiDataId"
    }
}
