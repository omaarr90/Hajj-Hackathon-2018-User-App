//
//  FoodItem.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import SwiftyJSON

struct FoodItem {
    var id: String
    var nameAr: String
    var nameEn: String
    var type: String
//    var barcode: String
    var timestamp: UInt
    var customerId: Int?
    var vmId: Int?
    var pictureUrl: String
    var calories: Int
    var weight: Int
    
    
    init?(_ json: JSON) {
        self.id = json["id"].stringValue
        self.nameAr = json["nameAr"].stringValue
        self.nameEn = json["nameEn"].stringValue
        self.type   = json["type"].stringValue
//        self.barcode = json["barcode"].stringValue
        self.timestamp = json["timestamp"].uIntValue
        self.customerId = json["customerId"].int
        self.vmId = json["vmId"].int
        self.pictureUrl = json["pictureUrl"].stringValue
        self.calories = json["calories"].intValue
        self.weight = json["calories"].intValue
    }
    
    init(_ nameAr: String, nameEn: String, type: String, timestamp: UInt, customerId: Int?, vmId: Int?, pictureUrl: String, calories: Int, weight: Int) {
        self.nameAr = nameAr
        self.nameEn = nameEn
        self.type = type
        self.timestamp = timestamp
        self.customerId = customerId
        self.vmId = vmId
        self.pictureUrl = pictureUrl
        self.calories = calories
        self.weight = weight
        
        self.id = UUID().uuidString
    }
    
    static func load(list: [JSON]) -> [FoodItem] {
        return list.compactMap { FoodItem($0)}
    }

}
