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
        rootViewController.tabBar.backgroundColor = UIColor.Theme.green
        rootViewController.tabBar.tintColor = UIColor.Theme.white
        rootViewController.tabBar.unselectedItemTintColor = UIColor.Theme.darkOliveGreen
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
