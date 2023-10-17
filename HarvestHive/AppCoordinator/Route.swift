//
//  Route.swift
//  HarvestHive
//
//  Created by Jess Lê on 8/7/23.
//

import Foundation

enum Route {
    case rootTabBar(TabBarRoute)

    // All the navigational routes for the Tabbar
    enum TabBarRoute {
        case hive (Hive)
    }

    // All the navigational routes for the Hive View
    enum Hive {
        case add
        case main
    }
}
