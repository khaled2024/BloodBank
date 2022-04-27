//
//  BloodType.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 27/04/2022.
//

import Foundation
struct BloodType:Codable{
    var status: Int
    var data: [BloodData]
}
struct BloodData:Codable{
    var id: String
    var name: String
}
