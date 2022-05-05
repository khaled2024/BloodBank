//
//  PurchaseOrder.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 05/05/2022.
//

import Foundation

struct PurchaseOrder:Codable{
    var status: Int
    var data: [PurchaseOrderData]
}
struct PurchaseOrderData:Codable{
    var id: String
    var p_id: String
    var blood_type: String
    var delivered_place: String
    var amount: String
    var time: String
}
