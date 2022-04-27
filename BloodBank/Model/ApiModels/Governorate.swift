//
//  Governorate.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 26/04/2022.
//

import Foundation

struct Governorate:Codable{
    var status: Int
    var data: [GovData]
}
struct GovData:Codable{
    var id: String
    var name: String
}
