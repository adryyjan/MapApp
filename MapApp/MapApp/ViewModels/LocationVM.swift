//
//  LocationVM.swift
//  MapApp
//
//  Created by Adrian Mazek on 20/07/2025.
//

import SwiftUI
import Observation
import MapKit

@Observable class LocationVM {

    var locations: [Location]
    var mapLocation: Location{
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
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
}

