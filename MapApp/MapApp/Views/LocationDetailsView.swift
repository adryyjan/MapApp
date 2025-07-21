//
//  LocationDetailsView.swift
//  MapApp
//
//  Created by Adrian Mazek on 21/07/2025.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
    
    @Environment(LocationVM.self) private var viewModel
    
    let location: Location
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
}

extension LocationDetailsView{
    
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
            
        }
    }
    
    private var descriptionSection: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            if let url = URL(string: location.link){
                Link("Read more on Wiki", destination: url)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
        }
    }
    
    private var mapLayer: some View {
        Map(position:
                .constant(
                    .region(
            MKCoordinateRegion(
                center: location.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                )
                            )
                        )
        ){
            Annotation(location.name, coordinate: location.coordinates) {
                PinView()
                    .scaleEffect(1.2)
                    .shadow(radius: 10)
                    .onTapGesture {
                            viewModel.showNextLocation(location: location)
                    }
                    .animation(
                        .easeInOut(duration: 0.5),
                      value: viewModel.mapLocation
                    )
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(contentMode: .fill )
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    
    private var backButton: some View {
        Button {
            viewModel.showLocationDetails.toggle()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundStyle(.primary)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 4)
                .padding()
        }

    }
    
}

#Preview {
    LocationDetailsView(location: LocationsDataService.locations.first!)
        .environment(LocationVM())
}
