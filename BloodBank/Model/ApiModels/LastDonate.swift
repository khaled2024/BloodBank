//
//  LastDonate.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 04/05/2022.
//

import Foundation
struct LastDonate:Codable{
    var status: Int
    var data: [LastDonateData]
}
struct LastDonateData:Codable{
    var id: String
    var donate_place_id: String
    var time: String
    var p_ssn: String
}
