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
    }
    
    func setup() {
        Logger.log(logSwitch, logMessage: "[Visits] Setup")        
        locationManager.delegate = self
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        Logger.log(logSwitch, logMessage: "[Visits] Did Change Authorization Status")
        switch status {
        case .Authorized:
            start()
        default:
            Logger.log(logSwitch, logMessage: "[Visits] Missing authorization")
        }
    }

    func start() {
        Logger.log(logSwitch, logMessage: "[Visits] Start – Monitored Locations:\(LocationStore.shared.savedLocations.count)")
        VisitsLog.write("[Visits] Start – Monitored Locations:\(LocationStore.shared.savedLocations.count)")
        locationManager.startMonitoringVisits()
    }
    
    func stop() {
        Logger.log(logSwitch, logMessage: "[Visits] Stop")
        VisitsLog.write("[Visits] Stop")
        locationManager.stopMonitoringVisits()
    }
    
    func locationManager(manager: CLLocationManager!, didVisit visit: CLVisit!) {
        Logger.log(logSwitch, logMessage: "[Visits] New Visit Information \(visit)")
        
        var visitDescription:NSString = ("\(visit)")
        if visit.departureDate.isEqualToDate(NSDate.distantFuture() as NSDate) {
            let matching = LocationStore.shared.matchingVisitWithSavedLocations(visit)
            if matching.state == true {
                Logger.log(logSwitch, logMessage: "[Visits] Arrived at \(matching.identifier!)")
                NotificationsCenter.shared.show("Visit • Arrived at \(matching.identifier!)", subTitle: visitDescription, info: nil, sound: true)
                VisitsLog.write("[Visits] Arrived at \(matching.identifier!)")
            } else {
                Logger.log(logSwitch, logMessage: "[Visits] Arrived *somewhere*")
                NotificationsCenter.shared.show("Visit • Arrived *somewhere*", subTitle: visitDescription, info: nil, sound: true)
                VisitsLog.write("[Visits] Arrived *somewhere*")
            }
        }
    }
        
}
