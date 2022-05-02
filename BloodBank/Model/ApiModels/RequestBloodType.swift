//
//  RequestBloodType.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 02/05/2022.
//

import Foundation
struct RequestBloodType:Codable{
    var status: Int
    var data: [RequestBloodTypeData]
}
struct RequestBloodTypeData:Codable{
    var id: String
    var type: String
}
