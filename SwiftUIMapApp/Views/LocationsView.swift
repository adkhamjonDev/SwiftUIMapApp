//
//  LocationsView.swift
//  SwiftUIMapApp
//
//  Created by Adkhamjon Rakhimov on 23/11/24.
//

import SwiftUI
import MapKit
struct LocationsView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    

    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
          
            
            mapLayer.ignoresSafeArea()
            
            VStack(spacing: 0.0) {
                header.padding().frame(maxWidth: maxWidthForIpad)
                Spacer()
                
                ZStack {
                    ForEach(viewModel.locations){ item in
                    
                        if viewModel.mapLocation == item {
                            LocationPreviewView(location: item)
                                .shadow(
                                    color: .black.opacity(0.3),
                                    radius: 20
                                )
                                .padding()
                                .frame(maxWidth: maxWidthForIpad)
                                .frame(maxWidth: .infinity)
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading))
                                )
                        }
                       
                    }
                }
            }
            .sheet(item: $viewModel.sheetLocation,onDismiss: nil){ location in
                LocationDetailView(location: location)
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView {
    private var header : some View {
        VStack(spacing: 0){
            Button {
                viewModel.toggleShowlist()
            } label: {
                
                Text(viewModel.mapLocation.name+", "+viewModel.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: viewModel.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: viewModel.showLocationList ? 180 : 0))
                        
                    }
            }
            
            
            if viewModel.showLocationList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(
            color:Color.black.opacity(0.3),
            radius: 20,
            x: 0,
            y: 0
        )
    }
    private var mapLayer: some View {
        Map(
            position: $viewModel.cameraPosition
            
        ){
            ForEach(viewModel.locations) { item in
            
                Marker("\(item.name)", coordinate: item.coordinates)
            }
        }
    }
}


