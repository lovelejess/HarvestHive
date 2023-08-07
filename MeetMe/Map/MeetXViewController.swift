//
//  MeetXViewController.swift
//  MeetMe
//
//  Created by Jess Lê on 8/7/23.
//

import UIKit

class MeetXViewController: UIViewController {

    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addX))
        button.tintColor = .black
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        navigationItem.rightBarButtonItem = addButton
    }

    @objc func addX() {
        print("JESS")
    }

}
