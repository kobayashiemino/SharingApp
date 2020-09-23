//
//  MypageCollectionReusableView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import SDWebImage
import ChameleonFramework

protocol MyPageProfileReusableViewDelegate: AnyObject {
    func didTapFollowButton()
}

protocol MyPageProfileReusableViewColorDelegate: AnyObject {
    func setColor(color: UIColor)
}

class MyPageProfileReusableView: UICollectionReusableView {
    static let identifier = "MypageProfileReusableView"
    
    public weak var delegate: MyPageProfileReusableViewDelegate?
    public weak var colorDelegate: MyPageProfileReusableViewColorDelegate?
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Follow", for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconImageView)
        addSubview(followButton)
        
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        
        fetchIconImage()
    }
    
    override func layoutSubviews() {
        iconImageView.frame = CGRect(x: 30, y: 0, width: 100, height: 100)
        iconImageView.center.y = height / 2
        iconImageView.layer.cornerRadius = iconImageView.width / 2
        
        followButton.frame = CGRect(x: width - 70, y: 30, width: 80, height: 52)
    }
    
    private func fetchIconImage() {
        guard let email = AuthManeger.email() else { return }
        DatabaseManeger.shared.getProfileData(email: email) { [weak self] (result) in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let profileInfos):
                guard let profileInfos = profileInfos as? [String: Any] else { return }
                profileInfos.forEach { key, value in
                    guard let profileInfo = value as? [String: Any] else { return }
                    let profile = Profile(dictionary: profileInfo)
                    let profilePictureURLString = profile.profilePicture
                    let profilePictureURL = URL(string: profilePictureURLString)
                    
                    DispatchQueue.main.async {
                        `self`.iconImageView.sd_setImage(with: profilePictureURL) { (image, error, _, _) in
                            guard let image = image, error == nil else { return }
                            let averageColorFromImage = UIColor(averageColorFrom: image)
                            let averageColor = AverageColor(color: averageColorFromImage)
                            `self`.followButton.backgroundColor = averageColor.averageColor
                            `self`.colorDelegate?.setColor(color: averageColor.averageColor)
                        }
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func didTapFollowButton() {
        delegate?.didTapFollowButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
