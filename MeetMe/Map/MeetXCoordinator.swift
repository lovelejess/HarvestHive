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
        rootViewController.isNavigationBarHidden = true
    }

    lazy var meetXCoordinator: UIHostingController = {
        let vc = UIHostingController(rootView: MapView())
        return vc
    }()

    func start() {
        rootViewController.setViewControllers([meetXCoordinator], animated: false)
    }
}
