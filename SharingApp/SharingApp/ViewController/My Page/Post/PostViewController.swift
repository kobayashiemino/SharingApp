//
//  PostViewController.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/03.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SafariServices
import ViewAnimator
import TPKeyboardAvoiding
import UITextView_Placeholder

class PostViewController: UIViewController {
    
    private let scrollView: TPKeyboardAvoidingScrollView = {
        let scrollView = TPKeyboardAvoidingScrollView()
        return scrollView
    }()

    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let addImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private let rankButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rosette"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.tintColor = .lightGray
        return button
    }()
    
    private let titleTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "TITLE"
        textField.title = "put item name"
        textField.textColor = .lightGray
        textField.lineColor = .lightGray
        textField.tintColor = .systemIndigo
        textField.selectedLineColor = .systemIndigo
        textField.selectedTitleColor = .systemIndigo
        return textField
    }()
    
    private let urlTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "URL"
        textField.title = "paste item's url"
        textField.textColor = .lightGray
        textField.lineColor = .lightGray
        textField.tintColor = .systemIndigo
        textField.selectedLineColor = .systemIndigo
        textField.selectedTitleColor = .systemIndigo
        return textField
    }()
    
    private let urlButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    private let captionTextView: UITextView = {
        let textView = UITextView()
        textView.tintColor = .lightGray
        textView.placeholder = "type your message"
        textView.font = UIFont(name: "Arial", size: 14)
        return textView
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("submit", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    private var selectRankPopup: SelectRankPopup = {
        let popup = SelectRankPopup(frame: (CGRect(x: 100, y: 100, width: 100, height: 100)))
        popup.alpha = 0
        popup.layer.cornerRadius = 5
        return popup
    }()
    
    private let blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.alpha = 0
        return effectView
    }()
    
    public static let dataFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .long
        formatter.locale = .current
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        addSubViews()
        selectRankPopup.delegate = self
    }
    
    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(itemImageView)
        itemImageView.addSubview(addImageButton)
        scrollView.addSubview(rankButton)
        scrollView.addSubview(titleTextField)
        scrollView.addSubview(urlTextField)
        urlTextField.addSubview(urlButton)
        scrollView.addSubview(captionTextView)
        scrollView.addSubview(submitButton)
        scrollView.addSubview(blurEffectView)
        scrollView.addSubview(selectRankPopup)
        
        titleTextField.delegate = self
        urlTextField.delegate = self
        
        addImageButton.addTarget(self, action: #selector(didTapAddImageButton), for: .touchUpInside)
        rankButton.addTarget(self, action: #selector(didTapRankButton), for: .touchUpInside)
        urlButton.addTarget(self, action: #selector(didTapUrlButton), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = view.bounds
        itemImageView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.width)
        addImageButton.frame = CGRect(x: (itemImageView.width - 100) / 2,
                                      y: (itemImageView.height - 100) / 2,
                                      width: 100,
                                      height: 100)
        addImageButton.layer.cornerRadius = addImageButton.width / 2
        titleTextField.frame = CGRect(x: 10,
                                      y: itemImageView.bottom + 10,
                                      width: view.width - 90,
                                      height: 52)
        rankButton.frame = CGRect(x: titleTextField.right + 20,
                                  y: itemImageView.bottom + 10,
                                  width: 52, height: 52)
        rankButton.layer.cornerRadius = rankButton.width / 2
        urlTextField.frame = CGRect(x: 10,
                                    y: titleTextField.bottom + 10,
                                    width: view.width - 20,
                                    height: 52)
        urlButton.frame = CGRect(x: urlTextField.width - 52,
                                 y: 0,
                                 width: 52,
                                 height: 52)
        urlButton.center.y = urlTextField.height / 2
        captionTextView.frame = CGRect(x: 10,
                                        y: urlTextField.bottom + 10,
                                        width: view.width - 20,
                                        height: view.height - 92 - (urlTextField.bottom + 10))
        submitButton.frame =  CGRect(x: 100,
                                     y: captionTextView.bottom + 20,
                                     width: view.width - 200,
                                     height: 52)
        submitButton.layer.cornerRadius = 10
        blurEffectView.frame = view.bounds
        selectRankPopup.frame = view.bounds
    }
    
    @objc private func didTapAddImageButton() {
        let alert = UIAlertController(title: "Image", message: "share your image", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "take photo", style: .default, handler: { (_) in
            self.takePhoto()
        }))
        alert.addAction(UIAlertAction(title: "select from Album", style: .default, handler: { (_) in
            self.selectFromAlbum()
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func takePhoto() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    private func selectFromAlbum() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    @objc internal func didTapRankButton() {
        
        selectRankPopup.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 1
            self.selectRankPopup.alpha = 1
            self.selectRankPopup.transform = CGAffineTransform.identity
        }
    }
    
    @objc private func didTapUrlButton() {
        let urlString = "https://www.google.com/webhp?hl=ja&sa=X&ved=0ahUKEwjE67_UsNPrAhUIG6YKHaMkAuIQPAgI"
        guard let url = URL(string: urlString) else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapSubmitButton() {
        
        submitButton.isEnabled = false
        
        guard let image = itemImageView.image else { return  }
        guard let imageData = image.pngData() else { return }
        let fileName = createFileName()
        StorageManeger.shared.uploadPostPhoto(with: imageData, fileName: fileName) { [weak self] result in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let urlString):
                print(urlString)
                `self`.saveToDatabase(urlString: urlString)
            case .failure(let error):
                print("error:\(error)")
            }
        }
    }
    
    private func saveToDatabase(urlString: String) {
        
        guard let title = titleTextField.text else { return }
        guard let itemSiteURL = urlTextField.text else { return }
        guard let caption = captionTextView.text else { return }
        let uploadedDate = PostViewController.dataFormatter.string(from: Date())
        
        let values = ["title": title,
                      "itemSiteURL": itemSiteURL,
                      "imageURL": urlString,
                      "caption": caption,
                      "uploadedDate": uploadedDate]
        
        DatabaseManeger.shared.postUpdate(values: values) { [weak self] (result) in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let ref):
                print(ref)
                `self`.submitButton.isEnabled = false
                `self`.dismiss(animated: true, completion: nil)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private func createFileName() -> String {
        
        guard let title = titleTextField.text else { return "" }
        let dateString = Self.dataFormatter.string(from: Date())
        let fileName = "\(title)_\(dateString)"
        
        return fileName
    }
}

extension PostViewController: SelectRankPopupDelegate {
    func didSelectRankButton() {
        
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 0
            self.selectRankPopup.alpha = 0
        }
    }
}

extension PostViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            urlTextField.becomeFirstResponder()
        } else if textField == urlTextField {
            captionTextView.becomeFirstResponder()
        }
        return true
    }
}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        addImageButton.removeFromSuperview()
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        itemImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}
