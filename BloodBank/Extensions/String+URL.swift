//
//  String+URL.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 21/03/2022.
//

import Foundation

// تحويل الصوره من ال api الي صوره 
extension String{
var asURL: URL?{
    return URL(string: self)
}
}
