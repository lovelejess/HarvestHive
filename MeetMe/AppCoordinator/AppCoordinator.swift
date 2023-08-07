//
//  AppCoordinator.swift
//  MeetMe
//
//  Created by Jess Lê on 8/7/23.
//

import Foundation
import UIKit

class AppCoordinator: Coordinatable {
    var childCoordinators: [Coordinatable] = []
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let tabBarCoordinator = TabBarCoordinator()
        tabBarCoordinator.start()
        childCoordinators = [tabBarCoordinator]
        window.rootViewController = tabBarCoordinator.rootViewController
    }
}
