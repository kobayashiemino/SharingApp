//
//  ProductDetailViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/06.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SafariServices
import ViewAnimator

class ProductDetailViewController: UIViewController {
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let backTopreviousViewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    private let SDGsLabel: UILabel = {
        let label = UILabel()
        label.text = "SDGs"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .lightGray
        label.clipsToBounds = true
        return label
    }()
    
    private let rankImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "rosette")
        image.tintColor = .lightGray
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TITLE"
        label.textColor = .systemGray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    private let websiteButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemGray, for: .normal)
        button.setTitle("TO WEBSITE", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        return button
    }()
    
    private let messageTextLabel: UILabel = {
        let label = UILabel()
        label.text = "MESSAGEMESSAGEMESSAGEMESSAGEMESSAGEMESSAGE"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private let SDGsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemGray, for: .normal)
        button.setTitle("TO SDGs Item", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        return button
    }()
    
    private let communityButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemGray, for: .normal)
        button.setTitle("TO Com Item", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        addSubViews()
    }
    
    private func addSubViews() {
        view.addSubview(itemImageView)
        itemImageView.addSubview(backTopreviousViewButton)
        itemImageView.addSubview(SDGsLabel)
        view.addSubview(rankImageView)
        view.addSubview(titleLabel)
        view.addSubview(websiteButton)
        view.addSubview(messageTextLabel)
        view.addSubview(SDGsButton)
        view.addSubview(communityButton)
        
        backTopreviousViewButton.addTarget(self, action: #selector(didTapBackTopreviousViewButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        itemImageView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.width)
        SDGsLabel.frame = CGRect(x: view.width - 60, y: 10, width: 50, height: 50)
        SDGsLabel.layer.cornerRadius = SDGsLabel.width / 2
        backTopreviousViewButton.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        titleLabel.frame = CGRect(x: 10,
                                  y: itemImageView.bottom + 10,
                                  width: view.width - 90,
                                  height: 52)
        rankImageView.frame = CGRect(x: titleLabel.right + 20,
                                     y: itemImageView.bottom + 10,
                                     width: 52, height: 52)
        rankImageView.layer.cornerRadius = rankImageView.width / 2
        messageTextLabel.frame = CGRect(x: 10,
                                        y: rankImageView.bottom + 10,
                                        width: view.width - 20,
                                        height: 80)
        websiteButton.frame = CGRect(x: 10,
                                     y: messageTextLabel.bottom + 10,
                                     width: view.width - 20,
                                     height: 52)
        SDGsButton.frame = CGRect(x: 10,
                                 y: websiteButton.bottom + 10,
                                 width: (view.width / 2) - 15,
                                 height: 52)
        communityButton.frame = CGRect(x: SDGsButton.right + 10,
                                      y: websiteButton.bottom + 10,
                                      width: (view.width / 2) - 15,
                                      height: 52)
    }
    
    @objc private func didTapBackTopreviousViewButton() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
