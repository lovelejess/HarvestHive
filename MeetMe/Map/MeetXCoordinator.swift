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
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .lightGray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        rootViewController.navigationBar.standardAppearance = appearance
        rootViewController.navigationBar.scrollEdgeAppearance = appearance
        rootViewController.navigationBar.compactScrollEdgeAppearance = appearance
    }

    lazy var meetXCoordinator: MeetXViewController = {
        let vc = MeetXViewController(rootView: MapView())
        vc.title = "MeetX Locations"
        return vc
    }()

    func start() {
        rootViewController.setViewControllers([meetXCoordinator], animated: false)
    }
}
