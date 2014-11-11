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
    
    let logSwitch:Bool = true
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    class var shared : VisitsCenter {
        struct Singleton {
            static let instance = VisitsCenter()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        Logger.log(logSwitch, logMessage: "[Visits] PermissionsCenter Init")
        //start()
    }

    func start() {
        Logger.log(logSwitch, logMessage: "[Visits] Start")
        VisitsLog.write(" Start")
        locationManager.startMonitoringVisits()
    }
    
    func stop() {
        Logger.log(logSwitch, logMessage: "[Visits] Stop")
        VisitsLog.write(" Stop")
        locationManager.stopMonitoringVisits()
    }
    
    func locationManager(manager: CLLocationManager!, didVisit visit: CLVisit!) {
        Logger.log(logSwitch, logMessage: "[Visits] New Visit Information \(visit)")
        var visitDescription:NSString = ("\(visit)")
        if visit.departureDate.isEqualToDate(NSDate.distantFuture() as NSDate) {
            Logger.log(logSwitch, logMessage: "[Visits] Arrived")
            NotificationsCenter.shared.show("Visit • Arrived", subTitle: visitDescription, info: nil, sound: true)
            VisitsLog.write(" Arrived \(visitDescription)")
        } else {
            Logger.log(logSwitch, logMessage: "[Visits] Left")
            NotificationsCenter.shared.show("Visit • Left", subTitle: visitDescription, info: nil, sound: true)
            VisitsLog.write(" Left \(visitDescription)")
        }
    }
    
}
