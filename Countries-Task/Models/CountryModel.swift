//
//  CountryModel.swift
//  Countries-Task
//
//  Created by hamzeh abdul kareem on 8/8/24.
//

import Foundation

struct CountryModel: Codable {
    let name: NameModel
    let currencies: [String: Currency]?
    let flags: FlagModel
}

struct NameModel: Codable {
    let common: String
    let official: String
}

struct FlagModel: Codable {
    let png: String
}

struct Currency: Codable {
    let name: String
    let symbol: String
}

enum CountriesItems {
    case countries
}
