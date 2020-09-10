//
//  MyPageViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/05.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.backgroundColor = .systemGray
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        
        createCollectionView()
    }
    
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let size: CGFloat = (view.width - 4) / 3
        layout.itemSize = CGSize(width: size, height: size)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.backgroundColor = .white
        collectionView.register(MyPageCollectionViewCell.self, forCellWithReuseIdentifier: MyPageCollectionViewCell.identifier)
        collectionView.register(MyPageProfileReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyPageProfileReusableView.identifier)
        collectionView.register(MyPageCategoryReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyPageCategoryReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        
        postButton.frame = CGRect(x: view.width - 70,
                                  y: view.height - 70,
                                  width: 60,
                                  height: 60)
        postButton.layer.cornerRadius = postButton.width / 2
    }
    
    @objc private func didTapPostButton() {
        let vc = PostViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
}

extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 0
        } else {
            return 30
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCollectionViewCell.identifier, for: indexPath) as! MyPageCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0 {
            return CGSize(width: view.width, height: view.height / 4)
        } else {
            return CGSize(width: view.width, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            let profile = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyPageProfileReusableView.identifier, for: indexPath) as! MyPageProfileReusableView
            profile.delegate = self
            return profile
        }
        let category = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyPageCategoryReusableView.identifier, for: indexPath) as! MyPageCategoryReusableView
        return category
    }
}

extension MyPageViewController: MyPageProfileReusableViewDelegate {
    func didTapFollowButton() {
        var mockData = [UserRelationship]()
        for x in 0..<10 {
            mockData.append(UserRelationship(username: "@Joe", name: "Joe Smith", followType: x % 2 == 0 ? .following : .not_Following))
        }
        let vc = ListViewController(data: mockData)
        navigationController?.pushViewController(vc, animated: true)
    }
}
