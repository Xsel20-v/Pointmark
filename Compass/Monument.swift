//
//  Monument.swift
//  Compass
//
//  Created by Jonathan Axel Benaya on 21/05/23.
//  Copyright © 2023 Pawel Kolano. All rights reserved.
//

import Foundation

struct Monument  {
    
    var name : String
    var lattitude : Double
    var longitude : Double
    var description : String
    var image : String
    
    init(name: String, lattitude: Double, longitude: Double, description : String, image : String) {
        self.name = name
        self.longitude = longitude
        self.lattitude = lattitude
        self.description = description
        self.image = image
    }
}
