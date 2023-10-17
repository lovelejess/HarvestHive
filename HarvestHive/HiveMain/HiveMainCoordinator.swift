//
//  HiveMainCoordinator.swift
//  HarvestHive
//
//  Created by Jess Lê on 8/7/23.
//

import Foundation
import SwiftUI
import UIKit

class HiveMainCoordinator: Coordinatable {

    var rootViewController: UINavigationController
    var childCoordinators: [Coordinatable] = []

    init() {
        rootViewController = UINavigationController()
        rootViewController.navigationBar.standardAppearance = NavigationBar.defaultAppearance()
        rootViewController.navigationBar.scrollEdgeAppearance = NavigationBar.defaultAppearance()
        rootViewController.navigationBar.compactScrollEdgeAppearance = NavigationBar.defaultAppearance()
    }

    lazy var hiveMainViewController: HiveMainViewController = {
        let locationManager = LocationManager()
        let viewModel = HiveMainViewModel()
        viewModel.coordinatorDelegate = self
        let mapViewModel = MapViewModel(locationManager: locationManager)
        let viewController = HiveMainViewController(rootView: MapView(viewModel: mapViewModel))
        viewController.viewModel = viewModel
        viewController.title = viewModel.title
        return viewController
    }()

    lazy var addXViewController: UIHostingController = {
        let viewModel = AddXViewModel()
        let viewController = UIHostingController(rootView: AddXView(viewModel: viewModel))
        viewController.title = viewModel.title
        return viewController
    }()

    func start() {
        rootViewController.setViewControllers([hiveMainViewController], animated: false)
    }
}

extension HiveMainCoordinator {
    func navigate(to route: Route) {
        switch route {
        case .rootTabBar(.hive(.add)):
            print("I'm adding")
            rootViewController.present(addXViewController, animated: true)
        default:
            print("nothing here")
        }
    }
}
