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

    lazy var meetXCoordinator: MeetXViewController = {
        let locationManager = LocationManager()
        let viewModel = MapViewModel(locationManager: locationManager)
        let viewController = MeetXViewController(rootView: MapView(viewModel: viewModel))
        viewController.title = viewModel.title
        return viewController
    }()

    func start() {
        rootViewController.setViewControllers([meetXCoordinator], animated: false)
    }
}
