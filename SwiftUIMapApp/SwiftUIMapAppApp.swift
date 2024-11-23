//
//  SwiftUIMapAppApp.swift
//  SwiftUIMapApp
//
//  Created by Adkhamjon Rakhimov on 22/11/24.
//

import SwiftUI

@main
struct SwiftUIMapAppApp: App {
    
    @StateObject private var viewModel:LocationsViewModel = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(viewModel)
        }
    }
}
