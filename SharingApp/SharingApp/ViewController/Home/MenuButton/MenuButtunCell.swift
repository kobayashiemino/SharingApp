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
    
    public var button: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.backgroundColor = .systemGray2
        button.tintColor = .white
        button.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        print("CGFloat.pi:\(CGFloat.pi)")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = bounds
        button.layer.cornerRadius = button.width / 2
    }
}
