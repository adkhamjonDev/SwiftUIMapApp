//
//  LocationsViewModel.swift
//  SwiftUIMapApp
//
//  Created by Adkhamjon Rakhimov on 23/11/24.
//

import Foundation
import Observation
import MapKit
import _MapKit_SwiftUI
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    var locations:[Location]
    
    // Current location map
    @Published var mapLocation:Location {
        didSet {
            updatePosition(location: mapLocation)
        }
    }
    
    // Currrent region on map
    @Published var cameraPosition:MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion())
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var showLocationList: Bool = false
    @Published var sheetLocation: Location? = nil
    
    init () {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updatePosition(location: locations.first!)
    }
    
    private func updatePosition(location:Location) {
        cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
            center: location.coordinates,
            span: mapSpan
        ))
    }
    
    func toggleShowlist() {
        withAnimation(.easeInOut) {
            showLocationList = !showLocationList
        }
    }
    
    func showNextLocation(of location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    
    func nextButtonPressed() {
        // get the current index
//        let currentIndex = locations.firstIndex{ location in
//            return location == mapLocation
//        }
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation}) else {
            print("Could not find current index in locations array! Should never happen")
            return
        }
        
        let nextIndex = currentIndex+1
        guard locations.indices.contains(nextIndex) else {
            // next index is NOT valid
            // restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(of: firstLocation)
            return
        }
        
        // Next index IS valid
        
        let nextLocation = locations[nextIndex]
        showNextLocation(of: nextLocation)
    }
}
