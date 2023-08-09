//
//  NavigationBar.swift
//  MeetMe
//
//  Created by Jess Lê on 8/9/23.
//

import Foundation
import UIKit

struct NavigationBar {
    static func defaultAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .lightGray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        return appearance
    }
}
