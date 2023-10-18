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
        .alert(isPresented: $viewModel.shouldShowErrorAlert) {
            Alert(
                title: Text("Current Location Not Available"),
                message: Text("Cannot retrieve Hives. Please update privacy in Settings > Privacy > Location > App.")
            )
        }
    }
//        switch viewModel.state {
//        case .idle:
//            // Render a clear color and start the loading process
//            // when the view first appears, which should make the
//            // view model transition into its loading state:
//            Color.clear.onAppear(perform: viewModel.fetchLocation)
//        case .loading:
//            ProgressView()
//        case .failed(let error):
//            Map(coordinateRegion: $viewModel.region,
//                interactionModes: .all,
//                showsUserLocation: true,
//                userTrackingMode: $tracking)
//            .alert(isPresented: $viewModel.shouldShowErrorAlert) {
//                Alert(
//                    title: Text("Current Location Not Available"),
//                    message: Text("Cannot retrieve Hives: \(error.localizedDescription). Please update privacy in Settings > Privacy > Location > App.")
//                )
//            }
//        case .loaded:
//            Map(coordinateRegion: $viewModel.region,
//                interactionModes: .all,
//                showsUserLocation: true,
//                userTrackingMode: $tracking)
//        }
//    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = MapViewModel(locationManager: LocationManager())
        MapView(viewModel: vm)
    }
}
