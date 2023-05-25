//
//  MonumentViewModel.swift
//  Compass
//
//  Created by Jonathan Axel Benaya on 24/05/23.
//  Copyright © 2023 Pawel Kolano. All rights reserved.
//

import Foundation

class MonumentViewModel : ObservableObject {
    
    @Published var monument : Monument?
    
    init(){
        monument = Monument(name: "Big Ben", lattitude: 51.5007, longitude: -0.1246, description: "Big Ben is a famous clock tower in London that has become an iconic symbol of the city.", image: "Big Ben")
    }
    
    func getMonument(monumentName : String) {
        if monumentName == "Eiffel Tower"{
            monument?.name = "Eiffel Tower"
            monument?.lattitude = 48.8584
            monument?.longitude = 2.2945
            monument?.description = "The Eiffel Tower is an iconic landmark in Paris, capturing the imagination with its elegant design and offering stunning panoramic views of the city."
            monument?.image = "Eiffel Tower"
        } else if monumentName == "Taj Mahal"{
            monument?.name = "Taj Mahal"
            monument?.lattitude = 78.0421
            monument?.longitude = 27.1751
            monument?.description = "The Taj Mahal is a breathtaking marble mausoleum in India, celebrated as one of the world's most beautiful and romantic architectural wonders."
            monument?.image = "Taj Mahal"
        } else if monumentName == "Big Ben" {
            monument?.name = "Big Ben"
            monument?.lattitude = 51.5007
            monument?.longitude = -0.1246
            monument?.description = "Big Ben is an iconic clock tower in London, known for its impressive architecture and famous chimes."
            monument?.image = "Big Ben"
        } else if monumentName == "Pisa Tower" {
            monument?.name = "Pisa Tower"
            monument?.lattitude = 43.7230
            monument?.longitude = 10.3966
            monument?.description = "The Leaning Tower of Pisa is a unique bell tower in Italy, recognized for its leaning stance and attracting visitors with its intriguing architectural quirk."
            monument?.image = "Pisa Tower"
        } else if monumentName == "Liberty" {
            monument?.name = "Statue of Liberty"
            monument?.lattitude = 40.6892
            monument?.longitude = -74.0445
            monument?.description = "The Statue of Liberty stands tall in New York Harbor, representing freedom and welcoming immigrants to the United States with its powerful symbolism."
            monument?.image = "Liberty"
        }else if monumentName == "Borobudur" {
            monument?.name = "Borobudur"
            monument?.lattitude = -7.6079
            monument?.longitude = 110.2038
            monument?.description = "Borobudur is an ancient Buddhist temple in Indonesia, revered for its intricate stone carvings and serving as a pilgrimage site for Buddhists."
            monument?.image = "Borobudur"
        } else if monumentName == "Monas" {
            monument?.name = "Monas"
            monument?.lattitude = -6.1754
            monument?.longitude = 106.8272
            monument?.description = "Monas, located in Jakarta, Indonesia, is a towering monument symbolizing the country's struggle for independence and offering panoramic views of the city from its observation deck."
            monument?.image = "Monas"
        }else if monumentName == "Pyramid of Giza" {
            monument?.name = "Pyramid of Giza"
            monument?.lattitude = 29.9792
            monument?.longitude = 31.1342
            monument?.description = "The Pyramid of Giza is an awe-inspiring ancient wonder in Egypt, housing the Great Sphinx and captivating visitors with its grandeur."
            monument?.image = "Pyramid of Giza"
        }else if monumentName == "Apple Park" {
            monument?.name = "Apple Park"
            monument?.lattitude = 37.3346
            monument?.longitude = -122.0090
            monument?.description = "Apple Park, located in California, is a futuristic corporate campus and headquarters of Apple Inc., renowned for its innovative design, eco-friendly features, and vast landscaped spaces."
            monument?.image = "Apple"
        }
    }

}
    
