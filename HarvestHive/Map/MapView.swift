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
        // Load spinning indicator until
        // a) a region that is non null island is retrieved
        // b) error is sent
        Map(coordinateRegion: $viewModel.region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $tracking)
        .alert(
            "Current Location Not Available",
            isPresented: $viewModel.shouldShowErrorAlert,
            presenting: $viewModel.errorDetails
        ) { details in
            Button("OK") {}
        } message: { details in
            Text("Cannot retrieve Hives. Please update privacy in Settings > Privacy > Location > App.")
        }
    }
}

struct LocationAlertDetails: Identifiable {
    let errorName: String
    let id = UUID()
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = MapViewModel(locationManager: LocationManager())
        MapView(viewModel: vm)
    }
}
