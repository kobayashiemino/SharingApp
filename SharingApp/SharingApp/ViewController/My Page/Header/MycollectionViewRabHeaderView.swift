//
//  tabHeaderView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/13.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class MycollectionViewRabHeaderView: UICollectionReusableView {
    static let identifier = "MycollectionViewRabHeaderView"
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemGray
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.tintColor = .systemGray
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray
        addSubview(postButton)
        addSubview(saveButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        postButton.frame = CGRect(x: 0, y: 0, width: width / 2, height: height)
        saveButton.frame = CGRect(x: width / 2, y: 0, width: width / 2, height: height)
    }
}
