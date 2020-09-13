//
//  SideMenuTableViewCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/04.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCell: UICollectionViewCell {
    
    static let identifier = "SideMenuTableViewCell"
    
    private let itemView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blur)
        view.alpha = 0.7
        return view
    }()
    
    private let thankButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rosette"), for: .normal)
        button.tintColor = .systemGray
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(itemView)
        itemView.addSubview(blurView)
        itemView.addSubview(thankButton)
    }
    
    override func layoutSubviews() {
        itemView.frame = bounds
        blurView.frame = CGRect(x: 0, y: width, width: width, height: height - width)
        
        let width: CGFloat = 30
        thankButton.frame = CGRect(x: -3, y: -3, width: width, height: width)
        thankButton.layer.cornerRadius = thankButton.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(post: Post) {
        let imageUrl = URL(string: post.imageURL)
        itemView.sd_setImage(with: imageUrl, completed: nil)
    }
}
