//
//  MapView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 29/3/24.
//

import SwiftUI
import MapKit

struct MapView<Presenter: MapPresenter>: View {
    
    @StateObject
    var presenter: Presenter
    @State private var position: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $position) {
            Marker(
                presenter.formattedAddress,
                systemImage: Assets.SystemImage.houseFill,
                coordinate: .init(
                    latitude: presenter.latitude,
                    longitude: presenter.longitude
                )
            )
        }
        .mapStyle(.hybrid(elevation: .realistic))
        .mapControlVisibility(.visible)
        .onAppear {
            position = setupPosition(
                latitude: presenter.latitude,
                longitude: presenter.longitude
            )
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle(presenter.formattedAddress)
    }
    
    private func setupPosition(latitude: Double, longitude: Double) -> MapCameraPosition {
        MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: presenter.latitude,
                    longitude: presenter.longitude
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
    MapView<MockMapPresenter>(presenter: MockMapPresenter())
}
