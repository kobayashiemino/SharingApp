//
//  MyPageCategoryReusableView.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

protocol MyPageCategoryReusableViewDelegate: AnyObject {
    func didTapCategoryCell(category: String)
}

class MyPageCategoryReusableView: UICollectionReusableView {
    
    static let identifier = "MyPageCategoryReusableView"
    
    private var collectionView: UICollectionView?
    
    private var categories = [Post]()
    
    weak var delegate: MyPageCategoryReusableViewDelegate?
    
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
        
        fetchPosts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView?.backgroundColor = .systemGray
        collectionView?.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    private func fetchPosts() {
        self.categories = []
        DatabaseManeger.shared.getPostData { [weak self] (result) in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let data):
                guard let postInfos = data as? [String: Any] else { return }
                postInfos.forEach { (key, value) in
                    guard let postInfo = value as? [String: Any] else { return }
                    let post = Post(dictionary: postInfo)
                    `self`.categories.append(post)
                }
                `self`.categories.sort {$0.uploadedDate > $1.uploadedDate}
                
                DispatchQueue.main.async {
                    `self`.collectionView?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func reloadData() {
        fetchPosts()
    }
}

extension MyPageCategoryReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCategoryCollectionViewCell.identifier, for: indexPath) as! MyPageCategoryCollectionViewCell
        cell.configure(post: categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        let categoryName = selectedCategory.category
        delegate?.didTapCategoryCell(category: categoryName)
    }
}
