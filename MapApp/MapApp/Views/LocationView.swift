//
//  LocationView.swift
//  MapApp
//
//  Created by Adrian Mazek on 20/07/2025.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @Environment(LocationVM.self) private var viewModel

    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    
    var body: some View {
        ZStack {
            Map(position: $position)
                        .ignoresSafeArea()
                        .onAppear {
                            position = .region(viewModel.mapRegion)
                        }
        }
    }
}

#Preview {
    LocationView()
        .environment(LocationVM())
}
