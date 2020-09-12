//
//  MyPageCategoryCollectionViewCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class MyPageCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyPageCategoryCollectionViewCell"
    
    private var post: Post?
    
    private var categoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("test", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGray
        button.clipsToBounds = true
        button.isEnabled = false
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.sizeToFit()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        categoryButton.frame = CGRect(x: 0, y: 10, width: width, height: height - 20)
        categoryButton.center.y = frame.height / 2
        categoryButton.layer.cornerRadius = categoryButton.width / 3
    }
    
    public func configure(post: Post) {
        categoryButton.setTitle(post.category, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
