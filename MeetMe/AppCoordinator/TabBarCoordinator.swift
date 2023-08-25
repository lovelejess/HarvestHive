//
//  TabBarCoordinator.swift
//  MeetMe
//
//  Created by Jess Lê on 8/7/23.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinatable {
    var childCoordinators: [Coordinatable] = []
    var rootViewController: UITabBarController

    init() {
        rootViewController = UITabBarController()
        rootViewController.tabBar.backgroundColor = .lightGray
        rootViewController.tabBar.tintColor = .darkGray
        rootViewController.tabBar.unselectedItemTintColor = .black
    }

    func start() {
        let meetXCoordinator = MeetXCoordinator()
        meetXCoordinator.start()
        childCoordinators.append(meetXCoordinator)

        let meetXViewController = meetXCoordinator.rootViewController
        meetXViewController.tabBarItem = UITabBarHelper.createItem(title: "MeetX", imageName: "mappin", selectedImageName: "mappin.and.ellipse")

        rootViewController.viewControllers = [meetXViewController]
    }
}


extension TabBarCoordinator {
    func navigate(to: Route) {
        return
    }
}
