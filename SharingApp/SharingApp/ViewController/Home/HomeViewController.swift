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
    private var sideMenuTableView = SideMenuTableView(with: ["+"])
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
        collectionView?.register(HomeCell.self,
                                 forCellWithReuseIdentifier: HomeCell.identifier)
        collectionView?.register(HomeHeader.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: HomeHeader.identifier)
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: -sideMenuViewDelegate
extension HomeViewController: SideMenuTableViewDelegate {
    func didSelectMenuItem(menuItem: String) {
        
        sideMenu?.dismiss(animated: true, completion: nil)
        title = menuItem
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}

// MARK: -UICollectionViewDelegate, UICollectionViewDatasource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: HomeHeader.identifier,
                                                                     for: indexPath) as! HomeHeader
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.width, height: 70)
    }
}
