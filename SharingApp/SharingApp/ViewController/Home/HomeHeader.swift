//
//  SideMenuTableViewHeaderCollectionReusableView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/04.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class HomeHeader: UICollectionReusableView {
    
    static let identifier = "SideMenuTableViewHeader"
    
    private let segmentControl: UISegmentedControl = {
        let items = ["saved","related"]
        let segment = UISegmentedControl(items: items)
        segment.selectedSegmentIndex = 0
        segment.tintColor = .systemGray
        return segment
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(segmentControl)
    }
    
    override func layoutSubviews() {
        
        let segWidth = width - 6
        segmentControl.frame = CGRect(x: (width - segWidth) / 2 ,
                                      y: (height - 50) / 2,
                                      width: segWidth,
                                      height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
