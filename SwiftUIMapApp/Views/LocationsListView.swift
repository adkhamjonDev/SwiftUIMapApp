//
//  LocationsListView.swift
//  SwiftUIMapApp
//
//  Created by Adkhamjon Rakhimov on 23/11/24.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var viewModel:LocationsViewModel
    var body: some View {
        List{
            ForEach(viewModel.locations){ item in
                
                Button {
                    viewModel.showNextLocation(of: item)
                } label: {
                    listRowView(item: item)
                }
                .padding(.vertical,4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}

extension LocationsListView {
    private func listRowView(item:Location) -> some View {
        HStack {
            if let imageName = item.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45,height: 45)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                
                Text(item.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
        }
    }
}
