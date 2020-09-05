//
//  MyPageCollectionViewCell.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class MyPageCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyPageCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
