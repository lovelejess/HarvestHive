//
//  MeetXViewController.swift
//  MeetMe
//
//  Created by Jess Lê on 8/7/23.
//

import UIKit
import MapKit
import SwiftUI

class MeetXViewController: UIHostingController<MapView> {

    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addX))
        button.tintColor = .white
        button.title = "Add"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = addButton
    }

    @objc func addX() {
        print("JESS")
    }
}
