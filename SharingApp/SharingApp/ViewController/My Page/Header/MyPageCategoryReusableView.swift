//
//  MyPageCategoryReusableView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class MyPageCategoryReusableView: UICollectionReusableView {
    
    static let identifier = "MyPageCategoryReusableView"
    
    private var collectionView: UICollectionView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 30)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.backgroundColor = .white
        collectionView.register(MyPageCategoryCollectionViewCell.self, forCellWithReuseIdentifier: MyPageCategoryCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
}

extension MyPageCategoryReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCategoryCollectionViewCell.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
