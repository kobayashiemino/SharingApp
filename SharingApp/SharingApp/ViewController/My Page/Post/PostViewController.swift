//
//  PostViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/03.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SafariServices
import ViewAnimator

class PostViewController: UIViewController {

    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    
    private let addImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private let rankButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rosette"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.tintColor = .lightGray
        return button
    }()
    
    private let titleTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "TITLE"
        textField.title = "put item name"
        textField.textColor = .lightGray
        textField.lineColor = .lightGray
        textField.tintColor = .systemIndigo
        textField.selectedLineColor = .systemIndigo
        textField.selectedTitleColor = .systemIndigo
        return textField
    }()
    
    private let urlTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "URL"
        textField.title = "paste item's url"
        textField.textColor = .lightGray
        textField.lineColor = .lightGray
        textField.tintColor = .systemIndigo
        textField.selectedLineColor = .systemIndigo
        textField.selectedTitleColor = .systemIndigo
        return textField
    }()
    
    private let urlButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    private let messageTextField: UITextView = {
        let textField = UITextView()
//        textField.placeholder = "MESSAGE"
//        textField.title = "tell the message"
//        textField.textColor = .lightGray
//        textField.lineColor = .lightGray
//        textField.tintColor = .systemIndigo
//        textField.selectedLineColor = .systemIndigo
//        textField.selectedTitleColor = .systemIndigo
        textField.tintColor = .lightGray
        textField.font = UIFont(name: "Arial", size: 20)
        return textField
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("submit", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    private var selectRankPopup: SelectRankPopup = {
        let popup = SelectRankPopup(frame: (CGRect(x: 100, y: 100, width: 100, height: 100)))
        popup.alpha = 0
        popup.layer.cornerRadius = 5
        return popup
    }()
    
    private let blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.alpha = 0
        return effectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        addSubViews()
        selectRankPopup.delegate = self
    }
    
    private func addSubViews() {
        view.addSubview(itemImageView)
        itemImageView.addSubview(addImageButton)
        view.addSubview(rankButton)
        view.addSubview(titleTextField)
        view.addSubview(urlTextField)
        urlTextField.addSubview(urlButton)
        view.addSubview(messageTextField)
        view.addSubview(submitButton)
        view.addSubview(blurEffectView)
        view.addSubview(selectRankPopup)
        
        titleTextField.delegate = self
        urlTextField.delegate = self
        
        addImageButton.addTarget(self, action: #selector(didTapAddImageButton), for: .touchUpInside)
        rankButton.addTarget(self, action: #selector(didTapRankButton), for: .touchUpInside)
        urlButton.addTarget(self, action: #selector(didTapUrlButton), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        itemImageView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.width)
        addImageButton.frame = CGRect(x: (itemImageView.width - 100) / 2,
                                      y: (itemImageView.height - 100) / 2,
                                      width: 100,
                                      height: 100)
        addImageButton.layer.cornerRadius = addImageButton.width / 2
        titleTextField.frame = CGRect(x: 10,
                                      y: itemImageView.bottom + 10,
                                      width: view.width - 90,
                                      height: 52)
        rankButton.frame = CGRect(x: titleTextField.right + 20,
                                  y: itemImageView.bottom + 10,
                                  width: 52, height: 52)
        rankButton.layer.cornerRadius = rankButton.width / 2
        urlTextField.frame = CGRect(x: 10,
                                    y: titleTextField.bottom + 10,
                                    width: view.width - 20,
                                    height: 52)
        urlButton.frame = CGRect(x: urlTextField.width - 52,
                                 y: 0,
                                 width: 52,
                                 height: 52)
        urlButton.center.y = urlTextField.height / 2
        messageTextField.frame = CGRect(x: 10,
                                        y: urlTextField.bottom + 10,
                                        width: view.width - 20,
                                        height: view.height - 92 - (urlTextField.bottom + 10))
        submitButton.frame =  CGRect(x: 100,
                                     y: messageTextField.bottom + 20,
                                     width: view.width - 200,
                                     height: 52)
        submitButton.layer.cornerRadius = 10
        blurEffectView.frame = view.bounds
        selectRankPopup.frame = view.bounds
    }
    
    @objc private func didTapAddImageButton() {
        
    }
    
    @objc internal func didTapRankButton() {
        
        selectRankPopup.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 1
            self.selectRankPopup.alpha = 1
            self.selectRankPopup.transform = CGAffineTransform.identity
        }
    }
    
    @objc private func didTapUrlButton() {
        let urlString = "https://www.google.com/webhp?hl=ja&sa=X&ved=0ahUKEwjE67_UsNPrAhUIG6YKHaMkAuIQPAgI"
        guard let url = URL(string: urlString) else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapSubmitButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PostViewController: SelectRankPopupDelegate {
    func didSelectRankButton() {
        
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 0
            self.selectRankPopup.alpha = 0
        }
    }
}

extension PostViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            urlTextField.becomeFirstResponder()
        } else if textField == urlTextField {
            messageTextField.becomeFirstResponder()
        } else if textField == messageTextField {
            
        }
        return true
    }
}
