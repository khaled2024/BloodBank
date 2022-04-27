//
//  City.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 26/04/2022.
//

import Foundation

struct City:Codable{
    var status: Int
    var data: [CityData]
}
struct CityData:Codable{
    var id: String
    var name: String
    var gov_id: String
}
