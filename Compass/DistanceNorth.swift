//
//  DistanceNorth.swift
//  Compass
//
//  Created by Pawel Kolano on 15/12/2019.
//  Copyright © 2019 Pawel Kolano. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

class DistanceNorth: NSObject, ObservableObject, CLLocationManagerDelegate {
    var objectWillChange = PassthroughSubject<Void, Never>()
    var meterDistance: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    private var destination = CLLocation(latitude: 0, longitude: 0)
    
    private let locationManager: CLLocationManager
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        self.locationManager.delegate = self
        self.setup()
    }
    
    private func setup() {
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
            self.locationManager.startUpdatingHeading()
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.meterDistance = String(format: "%.2f", location.distance(from: destination)/1000)
//            print(locationManager.location?.coordinate.latitude)
//            print(locationManager.location?.coordinate.longitude)
//            print(meterDistance)
//            print("==============")
        }
    }
    
    func setLatLong(lattitude : Double, longitude : Double){
//        print("**************")
        destination = CLLocation(latitude: lattitude, longitude: longitude)
//        print(destination.coordinate.latitude)
//        print(destination.coordinate.longitude)
//        print("**************")
        let loc = locationManager.location
        self.meterDistance = String(format: "%.2f", (loc ?? CLLocation(latitude: 0, longitude: 0).distance(from: destination)/1000))
        
    }
}
