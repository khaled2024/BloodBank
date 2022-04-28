//
//  UserStories.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 27/04/2022.

import Foundation
struct UserStories:Codable{
    var status: Int
    var data: [StoryData]
}
struct StoryData:Codable{
    var id: String
    var p_ssn: String
    var content: String
    var time: String
    var first_name: String
    var last_name: String
    var city_name: String
    var governorate_name: String
}


