//
//  MapAppApp.swift
//  MapApp
//
//  Created by Adrian Mazek on 20/07/2025.
//

import SwiftUI
import Observation

@main
struct MapAppApp: App {
    @State private var viewModel = LocationVM()
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environment(viewModel)
        }
        
    }
}
