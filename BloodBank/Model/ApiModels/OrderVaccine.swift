//
//  OrderVaccine.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 03/05/2022.
//

import Foundation
struct OrderVaccine:Codable{
    var status: Int
    var data: [OrderVaccineData]
}
struct OrderVaccineData:Codable{
    var order_id: String
    var vaccine_id: String
    var delivered_place: String
    var amount: String
    var time: String
    var p_ssn: String
}
