//
//  VendingMachine.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import SwiftyJSON
import GoogleMaps
import HDAugmentedReality

enum VM_TYPE {
    case Meal
    case Snak
    case Privlage }

struct VendingMachine {
    var addressAr: String
    var addressEn: String
    var foodList: [FoodItem]
    var id: Int
    var latitude: String
    var longitude: String
    var name: String
    var timestamp: UInt
    var marker : GMSMarker?
    var anotation:ARAnnotation?
    var type = VM_TYPE.Meal;
    
    init?(_ json: JSON) {
        self.addressAr = json["addressAr"].stringValue
        self.addressEn = json["addressEn"].stringValue
        self.foodList = FoodItem.load(list: json["foodList"].arrayValue)
        self.id   = json["id"].intValue
        self.latitude = json["latitude"].stringValue
        self.longitude = json["longitude"].stringValue
        self.name = json["name"].stringValue
        self.timestamp = json["timestamp"].uIntValue
        if(self.id % 2 == 0)
        {
        self.type = VM_TYPE.Meal
        }
        else
        {
        self.type = VM_TYPE.Snak
        }
        self.marker = GMSMarker(position: CLLocationCoordinate2D(latitude:Double(self.longitude)!,longitude:Double(self.latitude)!));
        self.createMarker()
        
        
        self.anotation = ARAnnotation(identifier: self.addressAr, title: self.addressAr, location: CLLocation(latitude: 21.6163356, longitude: 39.1550793));
    }
    
    static func load(list: [JSON]) -> [VendingMachine] {
        return list.compactMap { VendingMachine($0)}
    }
    
    func createMarker()  {
        // I have taken a pin image which is a custom image
        var markerImage:UIImage?
        switch self.type {
        case VM_TYPE.Meal:
             markerImage = UIImage(named: "MealMarker")!.withRenderingMode(.alwaysOriginal)
        case VM_TYPE.Privlage:
            markerImage = UIImage(named: "PrvilageMarker")!.withRenderingMode(.alwaysOriginal)
        case VM_TYPE.Snak:
            markerImage = UIImage(named: "SnakMarker")!.withRenderingMode(.alwaysOriginal)
  
        }
        let markerView = UIImageView(image: markerImage)
        self.marker?.iconView = markerView
        //self.marker?.snippet =
        self.marker?.title = self.addressAr
    }
}



