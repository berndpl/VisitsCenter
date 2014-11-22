//
//  Location.swift
//  LocationReminders
//
//  Created by Bernd Plontsch on 22/11/14.
//  Copyright (c) 2014 Bernd Plontsch. All rights reserved.
//

import UIKit
import CoreLocation

class Location: NSObject {
   
    var longitude:Double!
    var latitude:Double!
    var name:NSString!
    
    convenience init(latitude:Double, longitude:Double, name:NSString) {
        self.init()
        self.longitude = longitude
        self.latitude = latitude
        self.name = name
    }

    convenience init(location:CLLocation, name:NSString) {
        self.init()
        self.longitude = location.coordinate.longitude
        self.latitude = location.coordinate.latitude
        self.name = name
    }
    
    func simpleDescription()->NSString{
        return ("\t [Location] Name \(name) Long \(longitude) Lat \(latitude)")
    }

    
}
