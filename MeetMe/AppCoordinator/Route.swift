//
//  Route.swift
//  MeetMe
//
//  Created by Jess Lê on 8/7/23.
//

import Foundation

enum Route {
    case rootTabBar(TabBarRoute)

    // All the navigational routes for the Tabbar
    enum TabBarRoute {
        case meetX (MeetX)
    }

    // All the navigational routes for the MeetX View
    enum MeetX {
        case add
        case main
    }
}
