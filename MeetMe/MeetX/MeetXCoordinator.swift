//
//  MeetXCoordinator.swift
//  MeetMe
//
//  Created by Jess Lê on 8/7/23.
//

import Foundation
import SwiftUI
import UIKit

class MeetXCoordinator: Coordinatable {

    var rootViewController: UINavigationController
    var childCoordinators: [Coordinatable] = []

    init() {
        rootViewController = UINavigationController()
        rootViewController.navigationBar.standardAppearance = NavigationBar.defaultAppearance()
        rootViewController.navigationBar.scrollEdgeAppearance = NavigationBar.defaultAppearance()
        rootViewController.navigationBar.compactScrollEdgeAppearance = NavigationBar.defaultAppearance()
    }

    lazy var meetXViewController: MeetXViewController = {
        let locationManager = LocationManager()
        let viewModel = MeetXViewModel()
        viewModel.coordinatorDelegate = self
        let mapViewModel = MapViewModel(locationManager: locationManager)
        let viewController = MeetXViewController(rootView: MapView(viewModel: mapViewModel))
        viewController.viewModel = viewModel
        viewController.title = viewModel.title
        return viewController
    }()

    func start() {
        rootViewController.setViewControllers([meetXViewController], animated: false)
    }
}

extension MeetXCoordinator {
    func navigate(to route: Route) {
        switch route {
        case .rootTabBar(.meetX(.add)):
            print("I'm adding")
        default:
            print("nothing here")
        }
    }
}
