//
//  DonateReason.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 02/05/2022.
//

import Foundation
struct DonateReason:Codable{
    var status: Int
    var data: [DonateReasonData]
}
struct DonateReasonData:Codable{
    var id: String
    var reason: String
}
