//
//  MapView.swift
//  HarvestHive
//
//  Created by Jess Lê on 8/8/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var viewModel: MapViewModel
    @State var tracking: MapUserTrackingMode = .follow

    var body: some View {
        Map(coordinateRegion: $viewModel.region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $tracking)
        .alert(isPresented: $viewModel.shouldShowErrorAlert) {
                Alert(
                    title: Text("Current Location Not Available"),
                    message: Text("Cannot retrieve Hives. Please update privacy in Settings > Privacy > Location > App.")
                )
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = MapViewModel(locationManager: LocationManager())
        MapView(viewModel: vm)
    }
}
