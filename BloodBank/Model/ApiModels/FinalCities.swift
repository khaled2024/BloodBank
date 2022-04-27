//
//  FinalCities.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 27/04/2022.
//

import Foundation
struct FinalCities:Codable{
    var status: Int
    var data: [DataCities]
}
struct DataCities:Codable{
    var id: String
    var name: String
    var gov_id: String
}
