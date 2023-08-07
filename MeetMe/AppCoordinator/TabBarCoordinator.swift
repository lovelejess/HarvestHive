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
    }

    func start() {
        let meetXCoordinator = MeetXCoordinator()
        meetXCoordinator.start()
        childCoordinators.append(meetXCoordinator)

        let meetXViewController = meetXCoordinator.rootViewController
        setup(vc: meetXViewController, title: "MeetX", imageName: "mappin", selectedImageName: "mappin.and.ellipse")

        rootViewController.viewControllers = [meetXViewController]
    }

    private func setup(vc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        let defaultImage = UIImage(systemName: imageName)
        let selectedImage = UIImage(systemName: selectedImageName)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
    }
}
