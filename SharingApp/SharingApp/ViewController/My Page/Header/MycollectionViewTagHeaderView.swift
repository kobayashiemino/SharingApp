//
//  tabHeaderView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/13.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class MycollectionViewTagHeaderView: UICollectionReusableView {
    static let identifier = "MycollectionViewRabHeaderView"
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .lightGray
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.tintColor = .lightGray
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray
        addSubview(postButton)
        addSubview(saveButton)
        
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        postButton.frame = CGRect(x: 0, y: 0, width: width / 2, height: height)
        saveButton.frame = CGRect(x: width / 2, y: 0, width: width / 2, height: height)
    }
    
    @objc private func didTapPostButton() {
        saveButton.backgroundColor = .white
        saveButton.tintColor = .lightGray
        saveButton.layer.borderColor = UIColor.lightGray.cgColor
        saveButton.layer.borderWidth = 1
        postButton.backgroundColor = .lightGray
        postButton.tintColor = .white
    }
    
    @objc private func didTapSaveButton() {
        postButton.backgroundColor = .white
        postButton.tintColor = .lightGray
        postButton.layer.borderColor = UIColor.lightGray.cgColor
        postButton.layer.borderWidth = 1
        saveButton.backgroundColor = .lightGray
        saveButton.tintColor = .white
    }
}
