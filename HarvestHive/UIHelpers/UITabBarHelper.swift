//
//  UITabBarItem+Extensions.swift
//  HarvestHive
//
//  Created by Jess Lê on 8/7/23.
//

import Foundation
import UIKit

class UITabBarHelper {
    static func createItem(title: String, imageName: String, selectedImageName: String) -> UITabBarItem {
        let defaultImage = UIImage(systemName: imageName)
        let selectedImage = UIImage(systemName: selectedImageName)
        return UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
    }
}
