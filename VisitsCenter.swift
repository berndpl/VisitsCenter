//
//  VisitsCenter.swift
//  LocationReminders
//
//  Created by Bernd Plontsch on 11/11/14.
//  Copyright (c) 2014 Bernd Plontsch. All rights reserved.
//

import UIKit
import CoreLocation

class VisitsCenter: NSObject, CLLocationManagerDelegate {
    
    let logSwitch:Bool = false
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    class var shared : PermissionsCenter {
        struct Singleton {
            static let instance = PermissionsCenter()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        Logger.log(logSwitch, logMessage: "[Visits] PermissionsCenter Init")
        //start()
    }

    func start() {
        locationManager.startMonitoringVisits()
    }
    
    func stop() {
        locationManager.stopMonitoringVisits()
    }
    
    func locationManager(manager: CLLocationManager!, didVisit visit: CLVisit!) {
        Logger.log(logSwitch, logMessage: "[Visits] New Visit Information \(visit)")
        if visit.departureDate.isEqualToDate(NSDate.distantFuture() as NSDate) {
            Logger.log(logSwitch, logMessage: "[Visits] Arrived")
        } else {
            Logger.log(logSwitch, logMessage: "[Visits] Left")
        }
    }
    
}
