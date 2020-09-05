//
//  MenuButtunCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class MenuButtunCell: UICollectionViewCell {
    
    static let identifier = "MenuButtunCell"
    
    public var menuImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray2
        imageView.tintColor = .white
        imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(menuImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        menuImage.frame = bounds
        menuImage.layer.cornerRadius = menuImage.width / 2
    }
}
