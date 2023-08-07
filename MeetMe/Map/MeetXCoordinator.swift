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

        rootViewController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
    }

    lazy var meetXCoordinator: MeetXViewController = {
        let vc = MeetXViewController()
        return vc
    }()

    func start() {
        rootViewController.setViewControllers([meetXCoordinator], animated: false)
    }
}
