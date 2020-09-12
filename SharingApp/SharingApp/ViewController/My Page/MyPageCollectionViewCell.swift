//
//  MyPageCollectionViewCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import SDWebImage

class MyPageCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyPageCollectionViewCell"
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemPink
        
        addSubview(photoImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = bounds
    }
    
    public func configure(post: Post) {
        let imageURL = URL(string: post.imageURL)
        photoImageView.sd_setImage(with: imageURL, completed: nil)
    }
}
