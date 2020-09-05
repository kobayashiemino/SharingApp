//
//  MypageCollectionReusableView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class MyPageProfileReusableView: UICollectionReusableView {
    static let identifier = "MypageProfileReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
