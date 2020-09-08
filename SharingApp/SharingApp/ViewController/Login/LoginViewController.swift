//
//  LoginViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/03.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8
    }
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "email"
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "password"
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.addTarget(self,
                         action: #selector(didTapLoginButton),
                         for: .touchUpInside)
        return button
    }()
    
    private var createAccountButton: UIButton = {
         let button = UIButton()
         button.setTitle("Create Account", for: .normal)
         button.setTitleColor(.white, for: .normal)
         button.layer.masksToBounds = true
         button.layer.cornerRadius = Constants.cornerRadius
         button.backgroundColor = .systemBlue
         button.addTarget(self,
                          action: #selector(didTapLoginButton),
                          for: .touchUpInside)
         return button
     }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(createAccountButton)
        view.addSubview(loginButton)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        emailTextField.frame = CGRect(x: 10,
                                      y: 100,
                                      width: view.width - 20,
                                      height: 52)
        passwordTextField.frame = CGRect(x: 10,
                                         y: emailTextField.bottom + 10,
                                      width: view.width - 20,
                                      height: 52)
        createAccountButton.frame = CGRect(x: 10,
                                           y: passwordTextField.bottom + 10,
                                      width: view.width - 20,
                                      height: 52)
        loginButton.frame = CGRect(x: 10,
                                   y: createAccountButton.bottom + 10,
                                      width: view.width - 20,
                                      height: 52)
    }
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func didTapLoginButton() {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let usernameEmail = emailTextField.text, !usernameEmail.isEmpty, let password = passwordTextField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        var email: String?
        var username: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            email = usernameEmail
        } else {
            username = usernameEmail
        }
        
        AuthManeger.shared.loginUser(username: username, email: email, password: password) { [weak self](success) in
            
            DispatchQueue.main.sync {
                guard let `self` = self else { return }
                
                if success {
                    `self`.dismiss(animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Log in Error",
                                                  message: "We are not able to log you in",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .cancel, handler: nil))
                    `self`.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
}
