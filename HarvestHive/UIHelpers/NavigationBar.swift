//
//  NavigationBar.swift
//  HarvestHive
//
//  Created by Jess Lê on 8/9/23.
//

import Foundation
import UIKit

struct NavigationBar {
    static func defaultAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.Theme.green
        appearance.titleTextAttributes = [.foregroundColor: UIColor.Theme.white]
        return appearance
    }
}
