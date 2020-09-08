//
//  RegisterViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/08.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8
    }

    private let usernameTextField: UITextField = {
            let textField = UITextField()
            textField.backgroundColor = .secondarySystemBackground
            textField.placeholder = "username"
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
        
        private var registerButton: UIButton = {
            let button = UIButton()
            button.setTitle("Sign up", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.layer.masksToBounds = true
            button.layer.cornerRadius = Constants.cornerRadius
            button.backgroundColor = .systemBlue
            button.addTarget(self,
                             action: #selector(didTapregisterButton),
                             for: .touchUpInside)
            return button
        }()

        override func viewDidLoad() {
            super.viewDidLoad()

            view.addSubview(usernameTextField)
            view.addSubview(emailTextField)
            view.addSubview(passwordTextField)
            view.addSubview(registerButton)
            
            emailTextField.delegate = self
            passwordTextField.delegate = self
            
            registerButton.addTarget(self, action: #selector(didTapregisterButton), for: .touchUpInside)
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            usernameTextField.frame = CGRect(x: 10,
                                             y: 100,
                                             width: view.width - 20,
                                             height: 52)
            emailTextField.frame = CGRect(x: 10,
                                          y: usernameTextField.bottom + 10,
                                          width: view.width - 20,
                                          height: 52)
            passwordTextField.frame = CGRect(x: 10,
                                             y: emailTextField.bottom + 10,
                                          width: view.width - 20,
                                          height: 52)
            registerButton.frame = CGRect(x: 10,
                                       y: passwordTextField.bottom + 10,
                                          width: view.width - 20,
                                          height: 52)
        }
        
        @objc private func didTapregisterButton() {
            
            usernameTextField.resignFirstResponder()
            emailTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            
            guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty,let password = passwordTextField.text, !password.isEmpty, password.count >= 8 else {
                return
            }
            
            AuthManeger.shared.registerNewUser(username: username, email: email, password: password) { (registerd) in
                if registerd {
                    
                } else {
                    
                }
            }
        }
    }

    extension RegisterViewController: UITextFieldDelegate {
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == usernameTextField {
                emailTextField.becomeFirstResponder()
            } else if textField == emailTextField {
                passwordTextField.becomeFirstResponder()
            } else {
                didTapregisterButton()
            }
            return true
        }
    }
