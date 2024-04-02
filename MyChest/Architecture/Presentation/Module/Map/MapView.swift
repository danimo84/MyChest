//
//  MapView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 29/3/24.
//

import SwiftUI
import MapKit

struct MapView<ViewModel: MapViewModel>: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State private var position: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $position) {
            Marker(
                viewModel.formattedAddress,
                systemImage: Assets.SystemImage.houseFill,
                coordinate: .init(
                    latitude: viewModel.latitude,
                    longitude: viewModel.longitude
                )
            )
        }
        .mapStyle(.hybrid(elevation: .realistic))
        .mapControlVisibility(.visible)
        .onAppear {
            position = setupPosition(
                latitude: viewModel.latitude,
                longitude: viewModel.longitude
            )
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle(viewModel.formattedAddress)
    }
    
    private func setupPosition(latitude: Double, longitude: Double) -> MapCameraPosition {
        MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: viewModel.latitude,
                    longitude: viewModel.longitude
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: Theme.Map.spanLatitudeDelta,
                    longitudeDelta: Theme.Map.spanLongitudeDelta
                )
            )
        )
    }
}

#Preview {
    MapView<MockMapViewModel>()
        .environmentObject(MockMapViewModel())
}
