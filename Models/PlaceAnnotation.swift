//
//  PlaceAnnotation.swift
//  Hajj_Hackation_userApp
//
//  Created by Abdulaziz Aloumi on 02/08/2018.
//  Copyright © 2018 X. All rights reserved.
//

import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    
    init(location: CLLocationCoordinate2D, title: String) {
        self.coordinate = location
        self.title = title

        super.init()
    }
}
