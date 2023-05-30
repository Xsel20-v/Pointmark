//
//  ContentView.swift
//  Compass
//
//  Created by Pawel Kolano on 15/12/2019.
//  Copyright © 2019 Pawel Kolano. All rights reserved.
//

import Foundation
import SwiftUI


struct ContentView : View {
    @ObservedObject var compassHeading = CompassHeading()
    @ObservedObject var distanceNorth = DistanceNorth()
    @ObservedObject var localSolarTime = LocalSolarTime()
    
    @State var selection : String = "Monas"
//    @State var isHeading : Bool = false
    @StateObject var vm = MonumentViewModel()
    
    var monuments : [String] =
    ["Apple Park", "Big Ben", "Borobudur", "Eiffel Tower", "Liberty", "Monas", "Pyramid of Giza", "Pisa Tower", "Taj Mahal"]

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                Text("Choose a Landmark")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("BrokenWhite"))
                
                Picker(selection: $selection) {
                    ForEach(monuments, id: \.self) { monument in
                        Text(monument)
                            .tag(monument)
                    }
                    } label: {
                        Text(selection)
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(Color("DarkText"))
                    .frame(maxWidth : 235)
                    .padding()
                    .background(Color("YellowBackground"))
                    .cornerRadius(10)
                    .onChange(of: selection) { newValue in
                        vm.getMonument(monumentName: newValue)
                        distanceNorth.setLatLong(lattitude: vm.monument?.lattitude ?? 0, longitude: vm.monument?.longitude ?? 0)
                        compassHeading.setLatLong(lattitude: vm.monument?.lattitude ?? 0, longitude: vm.monument?.longitude ?? 0)
                    }
                ZStack {
                    Image("Compass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 270)
                        .offset(x: 1, y : -22)
                    ZStack {
                        Image("Inner Marker")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160)
                    }
                    .rotationEffect(Angle(degrees: -self.compassHeading.degrees))
                }
                .padding(.top, 30)
                
                .statusBar(hidden: true)
                
                HStack {
                    if checkHeadingToMonument() {
                        Image(vm.monument?.image ?? "")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 75, maxHeight: 120)
                            .padding(.trailing, 10)
                        ScrollView {
                            Text(vm.monument?.description ?? "Hello")
                                .foregroundColor(Color("DarkText"))
                        }
                    } else {
                        Text(compassHeading.textHeading)
                            .bold()
                            .font(.title2)
                            .foregroundColor(Color("DarkText"))
                    }
                }
                .frame(maxWidth: 310, maxHeight: 125)
                .padding(.horizontal, 20)
                .padding()
                .background(Color("BrokenWhite"))
                .cornerRadius(10)
                .padding(.bottom)
                
//                Text("\(compassHeading.degrees)")
//                Text("\(compassHeading.degreesToMonument)")
                
                if checkHeadingToMonument() {
                    VStack {
                        Text("You are currently heading to \(selection) with distance of \(self.distanceNorth.meterDistance) km")
                            .foregroundColor(Color("BrokenWhite"))
//                        Text("\(self.distanceNorth.meterDistance) km")
//                            .fontWeight(.light)
//                            .foregroundColor(Color("BrokenWhite"))
                       
                    }
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                }
                
                
                Spacer()
                
                
            }
            .padding()
        }
        .onAppear{
            vm.getMonument(monumentName: selection)
            distanceNorth.setLatLong(lattitude: vm.monument?.lattitude ?? 0, longitude: vm.monument?.longitude ?? 0)
        }
    }
    
}

struct ContentView_previews : PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}

extension ContentView {
    
    func checkHeadingToMonument() -> Bool {
        if compassHeading.degreesToMonument < 2 && compassHeading.degreesToMonument > -2 {
            return true
        } else {
            return false
        }
    }
    
}
