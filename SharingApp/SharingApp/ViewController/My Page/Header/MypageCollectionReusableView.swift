//
//  MypageCollectionReusableView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

protocol MyPageProfileReusableViewDelegate: AnyObject {
    func didTapFollowButton()
}

class MyPageProfileReusableView: UICollectionReusableView {
    static let identifier = "MypageProfileReusableView"
    
    public weak var delegate: MyPageProfileReusableViewDelegate?
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Follow", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemPink
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray
        
        addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        followButton.frame = CGRect(x: width - 70, y: 30, width: 80, height: 52)
    }
    
    @objc private func didTapFollowButton() {
        delegate?.didTapFollowButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
