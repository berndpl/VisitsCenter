//
//  VisitsCenter.swift
//  LocationReminders
//
//  Created by Bernd Plontsch on 11/11/14.
//  Copyright (c) 2014 Bernd Plontsch. All rights reserved.
//

import UIKit
import CoreLocation

class GeofenceCenter: NSObject, CLLocationManagerDelegate {
    
    let logSwitch:Bool = true
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    class var shared : GeofenceCenter {
        struct Singleton {
            static let instance = GeofenceCenter()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        Logger.log(logSwitch, logMessage: "[Geofence] Init")
    }
    
    func setup() {
        Logger.log(logSwitch, logMessage: "[Geofence] Setup")
        locationManager.delegate = self
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        Logger.log(logSwitch, logMessage: "[Geofence] Did Change Authorization Status")
        switch status {
        case .Authorized:
            start()
        default:
            Logger.log(logSwitch, logMessage: "[Geofence] Missing authorization")
        }
    }    
    
    func start() {
        Logger.log(logSwitch, logMessage: "[Geofence] Start")
        for item in LocationStore.shared.savedLocations {
            let location = item as Location
            let region = CLCircularRegion(circularRegionWithCenter: CLLocationCoordinate2D(latitude: location.latitude, longitude:location.longitude), radius: 20.0, identifier: location.name)
            locationManager.startMonitoringForRegion(region)
        }
        VisitsLog.write("[Geofence] Start \(locationManager.monitoredRegions.count)")
    }
    
    func stop() {
        Logger.log(logSwitch, logMessage: "[Geofence] Stop")
        for item:AnyObject in locationManager.monitoredRegions {
            let region = item as CLCircularRegion
            locationManager.stopMonitoringForRegion(region)
        }
        VisitsLog.write("[Geofence] Stop \(locationManager.monitoredRegions.count)")
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        NotificationsCenter.shared.show("Geofence • Entering \(region.identifier)", subTitle: region.identifier, info: nil, sound: true)
        VisitsLog.write("[Geofence] Entering at \(region.identifier)")
    }
    
}
