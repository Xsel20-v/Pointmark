//
//  CompassHeading.swift
//  Compass
//
//  Created by Pawel Kolano on 15/12/2019.
//  Copyright © 2019 Pawel Kolano. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

class CompassHeading: NSObject, ObservableObject, CLLocationManagerDelegate {
    var objectWillChange = PassthroughSubject<Void, Never>()
    var degrees: Double = .zero {
        didSet {
            objectWillChange.send()
        }
    }
    
    var degreesToMonument : Double = .zero {
        didSet {
            objectWillChange.send()
        }
    }
    
    var textHeading : String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    private let locationManager: CLLocationManager
    
    private var destination = CLLocation(latitude: 0, longitude: 0)
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        self.locationManager.delegate = self
        self.setup()
    }
    
    private func setup() {
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.headingAvailable() {
            self.locationManager.startUpdatingLocation()
            self.locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.degrees = newHeading.magneticHeading
        self.degreesToMonument = calculateBearing(currentLocation: locationManager.location ?? CLLocation(latitude: 0, longitude: 0), monumentLocation: destination) - self.degrees
        headingText(bearing: degreesToMonument)
    }
    
    func calculateBearing(currentLocation : CLLocation, monumentLocation : CLLocation) -> Double{
        let currentLat = currentLocation.coordinate.latitude
        let currentLon = currentLocation.coordinate.longitude
        
        let monumentLat = monumentLocation.coordinate.latitude
        let monumentLon = monumentLocation.coordinate.longitude
        
        let lonDiff = monumentLon - currentLon
        
        let y = sin(lonDiff) * cos(monumentLat)
        let x = cos(currentLat) * sin(monumentLat) - sin(currentLat) * cos(monumentLat) * cos(lonDiff)
        var bearing = atan2(y, x)
        
        // Convert bearing to degrees
        bearing = bearing.radiansToDegrees
        
        // Adjust the range of the bearing from -180 to 180 degrees
        bearing = (bearing + 360).truncatingRemainder(dividingBy: 360)
        
        return bearing
    }
    
    func setLatLong(lattitude : Double, longitude : Double){
        destination = CLLocation(latitude: lattitude, longitude: longitude)
        let head = locationManager.heading
        self.degrees = head?.magneticHeading ?? CLLocationDirection()
        self.degreesToMonument = calculateBearing(currentLocation: locationManager.location ?? CLLocation(latitude: 0, longitude: 0), monumentLocation: destination) - self.degrees
        headingText(bearing: degreesToMonument)
    }
    
    func headingText(bearing : Double) {
        if bearing < 0 && bearing > -180 || bearing > 180 && bearing < 360 {
            textHeading = "Turn your phone to the left"
        } else {
            textHeading = "Turn your phone to the right"
        }
    }
    
}

extension Double {
    var degreesToRadians: Double { return self * .pi / 180 }
    var radiansToDegrees: Double { return self * 180 / .pi }
}
