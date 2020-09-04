//
//  ViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/03.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    private var sideMenu: SideMenuNavigationController?
    private let sideMenuTableView = SideMenuTableView(with: ["リンゴ",
                                                             "ゴリラ",
                                                             "ラッパ",
                                                             "パンダ",
                                                             "ダンゴ",
                                                             "ゴジラ"])
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let width: CGFloat = (view.width - 9)/2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView?.backgroundColor = .white
        collectionView?.register(SideMenuTableViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        if let collectionView = collectionView {
            view.addSubview(collectionView)
        }
        
        setupNavBarItem()
        setupSideMenu()
    }
    
    private func setupSideMenu() {
        sideMenu = SideMenuNavigationController(rootViewController: sideMenuTableView)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        sideMenuTableView.delegate = self
    }
    
    private func setupNavBarItem() {
        let item = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"),
                                   style: .done,
                                   target: self,
                                   action: #selector(didTapSideMenubutton))
        navigationItem.leftBarButtonItem = item
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc private func didTapSideMenubutton() {
        
        if let sideMenu = self.sideMenu {
            present(sideMenu, animated: true)
        }
    }
}

// MARK: -sideMenuViewDelegate
extension HomeViewController: SideMenuTableViewDelegate {
    func didSelectMenuItem(named: String) {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}

// MARK: -UICollectionViewDelegate, UICollectionViewDatasource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SideMenuTableViewCell
        return cell
    }
}
