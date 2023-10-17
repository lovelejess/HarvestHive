//
//  Coordinatable.swift
//  HarvestHive
//
//  Created by Jess Lê on 8/7/23.
//

import Foundation

protocol Coordinatable: AnyObject {
    var childCoordinators: [Coordinatable] { get }
    func start()
    func navigate(to route: Route)
}
