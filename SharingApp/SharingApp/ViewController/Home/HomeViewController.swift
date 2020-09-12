//
//  ViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/03.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import SideMenu
import ViewAnimator
import Firebase

class HomeViewController: UIViewController {
    
    private var sideMenu: SideMenuNavigationController?
    private var sideMenuTableView = SideMenuTableView(with: ["+"])
    private var collectionView: UICollectionView?
    private let menuButtons = MenuButtuns()
    private var posts = [Post]()
    
    private let menuButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray2
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didTapBaseButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .systemPink
        return button
    }()
    
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
        
        view.addSubview(menuButton)
        view.addSubview(menuButtons)
        menuButtons.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPosts()
    }
    
    private func fetchPosts() {
        
        self.posts = []
        
        DatabaseManeger.shared.getPostData { [weak self] result in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let data):
                guard let postInfos = data as? [String: Any] else { return }
                postInfos.forEach { (key, value) in
                    guard let postInfo = value as? [String: Any] else { return }
                    let post = Post(dictionary: postInfo)
                    `self`.posts.append(post)
                }
                `self`.posts.sort {$0.uploadedDate > $1.uploadedDate}
                
                DispatchQueue.main.async {
                    `self`.collectionView?.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuButtons.frame = CGRect(x: view.width - 70, y: view.height - 450, width: 60, height: 360)
        menuButton.frame = CGRect(x: view.width - 70, y: view.height - 70, width: 60, height: 60)
        menuButton.layer.cornerRadius = menuButton.width / 2
    }
    
    private func setupSideMenu() {
        sideMenu = SideMenuNavigationController(rootViewController: sideMenuTableView)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        sideMenuTableView.delegate = self
    }
    
    private func setupNavBarItem() {
        let leftButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"),
                                   style: .done,
                                   target: self,
                                   action: #selector(didTapSideMenubutton))
        let rightButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                             style: .done,
                                             target: self,
                                             action: #selector(didLogOutbutton))
        navigationItem.leftBarButtonItem = leftButtonItem
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = rightButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc private func didTapSideMenubutton() {
        
        if let sideMenu = self.sideMenu {
            present(sideMenu, animated: true)
        }
    }
    
    @objc private func didLogOutbutton() {
        
        DispatchQueue.main.async {
            AuthManeger.shared.logout { [weak self] (success) in
                
                guard let `self` = self else { return }
                
                if success {
                    let vc = LoginViewController()
                    `self`.present(vc, animated: true, completion: nil)
                } else {
                    
                }
            }
        }
    }
    
    @objc private func didTapBaseButton() {
        menuButtons.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        menuButtons.collectionView?.isHidden = false
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        let roteteAnimation = AnimationType.rotate(angle: CGFloat.pi / 6)
        guard let cells = menuButtons.collectionView?.visibleCells else { return }
        UIView.animate(views: cells, animations: [zoomAnimation, roteteAnimation])
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: -MenuButtonsDelegate
extension HomeViewController: MenuButtunsDelegate {
    
    func didTapNotificationButton() {
        let vc = NotificationViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
    func didTapInfoButton() {
//        let post = UserPost(identifier: "",
//                            postType: .photo,
//                            thumnailImage: URL(string: "https://www.google.com/")!,
//                            postURL: URL(string: "https://www.google.com/")!,
//                            caption: nil,
//                            likeCount: [],
//                            coment: [],
//                            createdDate: Date(),
//                            taggedUsers: [])
//        let vc = ProductDetailViewController(post: post)
//        let navVC = UINavigationController(rootViewController: vc)
//        navVC.modalPresentationStyle = .fullScreen
//        present(navVC, animated: true, completion: nil)
    }
    
    func didTapMyPageButton() {
        let vc = MyPageViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
    func didTapSearchButton() {
        let vc = SearchViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
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
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
        cell.configure(post: posts[indexPath.row])
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let vc = ProductDetailViewController(post: post)
        navigationController?.pushViewController(vc, animated: true)
    }
}


