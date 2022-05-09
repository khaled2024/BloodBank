//
//  Going_Donners.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 09/05/2022.
//

import Foundation
struct Going_Donners:Codable{
    var status: Int
    var data: [Going_DonnersData]
}
struct Going_DonnersData:Codable{
    var request_id: String
    var donner_id: String
}
