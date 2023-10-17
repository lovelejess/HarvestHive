//
//  TabBarCoordinator.swift
//  HarvestHive
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
        let hiveMainCoordinator = HiveMainCoordinator()
        hiveMainCoordinator.start()
        childCoordinators.append(hiveMainCoordinator)

        let hiveMainViewController = hiveMainCoordinator.rootViewController
        hiveMainViewController.tabBarItem = UITabBarHelper.createItem(title: "Hives", imageName: "mappin", selectedImageName: "mappin.and.ellipse")

        rootViewController.viewControllers = [hiveMainViewController]
    }
}


extension TabBarCoordinator {
    func navigate(to: Route) {
        return
    }
}
