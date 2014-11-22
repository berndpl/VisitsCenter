//
//  LocationStore.swift
//  LocationReminders
//
//  Created by Bernd Plontsch on 22/11/14.
//  Copyright (c) 2014 Bernd Plontsch. All rights reserved.
//

import UIKit
import CoreLocation

class LocationStore: NSObject {
   
    var logSwitch:Bool = true
    
    var savedLocations:NSMutableArray = NSMutableArray()
    
    class var shared : LocationStore {
        struct Singleton {
            static let instance = LocationStore()
        }
        return Singleton.instance
    }

    override init() {
        super.init()
        Logger.log(logSwitch, logMessage: "[Store] Init")
        setupTestLocations()
    }
    
    func setupTestLocations() {
        savedLocations.addObjectsFromArray([
            Location(latitude: 52.545030, longitude: 13.423450, name: "Home"),
            Location(latitude: 52.537402, longitude: 13.395527, name: "6Wunderkinder, Work"),
            Location(latitude: 52.543758, longitude: 13.426481, name: "Penny, Supermarket"),
            Location(latitude: 52.543758, longitude: 13.426776, name: "Bio Company, Supermarket"),
            Location(latitude: 52.547569, longitude: 13.419035, name: "Kaisers, Supermarket"),
            Location(latitude: 52.543101, longitude: 13.417494, name: "Caffeina, Späti"),
            Location(latitude: 52.543040, longitude: 13.421083, name: "Afri, Späti"),
            Location(latitude: 52.544276, longitude: 13.423081, name: "Vietnam, Späti"),
            Location(latitude: 52.544097, longitude: 13.417822, name: "Tuerkischer, Späti"),
            Location(latitude: 52.544263, longitude: 13.422625, name: "Bekarei, Café"),
            Location(latitude: 52.545875, longitude: 13.417809, name: "Za Maria, Pizza")
            ])
    }
    
    //MARK: HELPER
    
    func matchingVisitWithSavedLocations(visit:CLVisit)->(state:Bool,identifier:NSString?) {
        for item in savedLocations {
            let location = item as Location
            let visitLocation:CLLocation = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)
            let checkLocation:CLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            if matchingLocations(checkLocation, locationB: visitLocation, accuracy: visit.horizontalAccuracy) == true {
                return (true,location.name)
            }
        }
        return (false,nil)
    }
    
    func matchingLocations(locationA:CLLocation,locationB:CLLocation,accuracy:CLLocationDistance)->Bool {
        let distance:CLLocationDistance = locationA.distanceFromLocation(locationB)
        if distance < accuracy {
            return true
        } else {
            return false
        }
    }
    
}
