//
//  LocationVM.swift
//  MapApp
//
//  Created by Adrian Mazek on 20/07/2025.
//

import SwiftUI
import Observation
import MapKit

@Observable final class LocationVM  {

    var locations: [Location]
    var mapLocation: Location{
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    var showLocationList: Bool = false
    
    init() {
        self.locations = LocationsDataService.locations
        self.mapLocation = LocationsDataService.locations.first!
        self.updateMapRegion(location: LocationsDataService.locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates, span: mapSpan
            )
        }
    }
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            self.showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed() {
        withAnimation(.easeInOut(duration: 3.0)) {
            guard let currentIndex = locations.firstIndex(of: mapLocation) else {return}
            let nextIndex = (currentIndex + 1) % locations.count
            showNextLocation(location: locations[nextIndex])

        }
    }
}
