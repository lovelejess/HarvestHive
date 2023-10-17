//
//  UIColor+Extensions.swift
//  HarvestHive
//
//  Created by Jess Lê on 10/17/23.
//

import Foundation
import UIKit

public extension UIColor {

    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var scrubbedHex = hex

        if (scrubbedHex.contains("#")) {
            scrubbedHex.remove(at: scrubbedHex.startIndex)
        }

        var rgbValue:UInt64 = 0
        Scanner(string: scrubbedHex).scanHexInt64(&rgbValue)

        let redValue = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let greenValue = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blueValue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
    }

    // Themes borrowed from https://coolors.co/palettes/trending
    struct Theme {
        public static let green = UIColor(hex: "588157")
        public static let forestGreen = UIColor(hex: "3D5A80")
        public static let terracotta = UIColor(hex: "bc6c25")
        public static let darkOliveGreen = UIColor(hex: "283618")
        public static let white = UIColor(hex: "fefae0")
    }
}
