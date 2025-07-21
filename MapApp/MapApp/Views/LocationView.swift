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

            Map(position: $position){
                ForEach(viewModel.locations){ location in
                    Annotation(location.name, coordinate: location.coordinates) {
                        PinView()
                            .scaleEffect(viewModel.mapLocation == location ? 1.2 : 0.7)
                    }
                }
            }
                
                .ignoresSafeArea()
                .animation(
                  .easeInOut(duration: 3.0),           // to Twoje 3 sekundy
                  value: viewModel.     // patrz na tę wartość
                )
                .onAppear {
                    position = .region(viewModel.mapRegion)
                }
                .onChange(of: viewModel.mapRegion) {
                    position = .region(viewModel.mapRegion)
                }
            
            
            VStack(spacing: 0) {
                header
                    .padding()
                
                Spacer()
                
                ZStack {
                    ForEach(viewModel.locations){ location in
                        if viewModel.mapLocation == location {
                            LocationPreviewView(location: location)
                                .shadow(color: .black.opacity(0.3), radius: 20)
                                .padding()
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        }
                        
                    }
                }
            }
        }
    }
}

extension LocationView {
    
    private var header: some View {
        VStack {
            Button {
                viewModel.toggleLocationList()
            } label: {
                Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: viewModel.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down" )
                            .font(.headline)
                            .foregroundStyle(Color.primary)
                            .padding(.horizontal)
                            .rotationEffect(Angle(degrees: viewModel.showLocationList ? 180 : 0))
                    }
            }
            if viewModel.showLocationList {
                LocationsListView()
            }
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
}


extension MKCoordinateRegion: @retroactive Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center.latitude  == rhs.center.latitude &&
        lhs.center.longitude == rhs.center.longitude &&
        lhs.span.latitudeDelta  == rhs.span.latitudeDelta &&
        lhs.span.longitudeDelta == rhs.span.longitudeDelta
    }
}


#Preview {
    LocationView()
        .environment(LocationVM())
}
