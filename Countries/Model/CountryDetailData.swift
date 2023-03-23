//
//  CountryDetailData.swift
//  Countries
//
//  Created by Ömer Karabulut on 21.03.2023.
//

import Foundation

struct CountryDetailData: Codable {
    let capital, code, callingCode: String
    let currencyCodes: [String]
    let flagImageURI: String
    let name: String
    let numRegions: Int
    let wikiDataID: String

    enum CodingKeys: String, CodingKey {
        case capital, code, callingCode, currencyCodes
        case flagImageURI = "flagImageUri"
        case name, numRegions
        case wikiDataID = "wikiDataId"
    }
}
