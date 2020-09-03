//
//  ViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/03.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    private let sideMenu = SideMenuNavigationController(rootViewController: UIViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupNavBarItem()
        setupSideMenu()
    }
    
    private func setupSideMenu() {
        sideMenu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
    }
    
    private func setupNavBarItem() {
        let item = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"),
                                   style: .done,
                                   target: self,
                                   action: #selector(didTapSideMenubutton))
        navigationItem.leftBarButtonItem = item
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc private func didTapSideMenubutton() {
        present(sideMenu, animated: true)
    }
}

