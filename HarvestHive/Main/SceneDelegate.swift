//
//  SceneDelegate.swift
//  HarvestHive
//
//  Created by Jess Lê on 8/7/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: AppCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let applicationCoordinator = AppCoordinator(window: window)
            applicationCoordinator.start()
            self.appCoordinator = applicationCoordinator
            window.makeKeyAndVisible()
        }
    }
}

