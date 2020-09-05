//
//  LoginViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/03.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.addTarget(self,
                         action: #selector(didTapLoginButton),
                         for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        let width: CGFloat = 100
        loginButton.frame = CGRect(x: (view.width - width) / 2,
                                   y: (view.height - width) / 2,
                                   width: width,
                                   height: width)
    }
    
    @objc private func didTapLoginButton() {
        let vc = HomeViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}
