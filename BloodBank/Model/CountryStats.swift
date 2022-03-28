//
//  CoronaStats.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/03/2022.
//

import Foundation
//MARK: -
// لازم الترتيب نفس الترتيب بتاع الjson مهمه

struct CountryStats: Codable {
    let country: String?
    let countryInfo: CountryInfo?
    let cases: Int?
    let deaths: Int?
    let recovered: Int?
    let active: Int?
    let critical: Int?
    let population: Int?
}

struct CountryInfo: Codable{
    let flag: String?
}
