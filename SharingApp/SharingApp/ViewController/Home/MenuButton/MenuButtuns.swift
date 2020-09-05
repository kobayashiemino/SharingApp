//
//  MenuButtuns.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import ViewAnimator

class MenuButtuns: UIView {
    
    public var collectionView: UICollectionView?
    
    private let buttonImages: [String] = ["house.fill", "bag.fill","person.fill", "bell.fill"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
    
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        collectionView.register(MenuButtunCell.self, forCellWithReuseIdentifier: MenuButtunCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView?.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuButtuns: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuButtunCell.identifier, for: indexPath) as! MenuButtunCell
        let image = buttonImages[indexPath.row]
        cell.button.setImage(UIImage(systemName: image), for: .normal)
        return cell
    }
}
