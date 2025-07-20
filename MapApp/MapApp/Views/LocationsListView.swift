//
//  LocationsListView.swift
//  MapApp
//
//  Created by Adrian Mazek on 20/07/2025.
//

import SwiftUI

struct LocationsListView: View {
    @Environment(LocationVM.self) private var viewModel
    
    var body: some View {
        List {
            ForEach(viewModel.locations) { location in
                Button {
                    viewModel.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                    .padding(.vertical,4)
                    .listRowBackground(Color.clear)
            }
        
            
        }
        
    }
        
}
    

extension LocationsListView {
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.ultraThinMaterial)
    }
}

#Preview {
    LocationsListView()
        .environment(LocationVM())
}


