//
//  StorageManeger.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/08.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import FirebaseStorage

class StorageManeger {
    static let shared = StorageManeger()
    
    private let storage = Storage.storage().reference()
    
    public typealias uploadPictureCompletion = (Result<String, Error>) -> Void
    
    enum StorageManegerError: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }
    
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping uploadPictureCompletion) {
        storage.child("images/\(fileName)").putData(data, metadata: nil) { [weak self] (metadata, error) in
            guard let `self` = self else { return }
            
            guard error == nil else {
                completion(.failure(StorageManegerError.failedToUpload))
                return
            }
            
            `self`.storage.child("images/\(fileName)").downloadURL { (url, error) in
                guard let url = url else {
                    completion(.failure(StorageManegerError.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                completion(.success(urlString))
            }
        }
    }
    
    public func uploadPostPhoto(with data: Data, fileName: String, completion: @escaping uploadPictureCompletion) {
        storage.child("post_imeges/\(fileName)").putData(data, metadata: nil) { [weak self] (metadata, error) in
            guard error == nil else {
                completion(.failure(StorageManegerError.failedToUpload))
                return
            }
            self?.storage.child("post_imeges/\(fileName)").downloadURL(completion: { (url, error) in
                guard let url = url else {
                    completion(.failure(StorageManegerError.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                completion(.success(urlString))
            })
        }
    }
    
    public func uploadPostVideo(with fileUrl: URL, fileName: String, completion: @escaping uploadPictureCompletion) {
        storage.child("post_video/\(fileName)").putFile(from: fileUrl, metadata: nil) { [weak self] (metadata, error) in
            guard error == nil else {
                completion(.failure(StorageManegerError.failedToUpload))
                return
            }
            
            self?.storage.child("post_video/\(fileName)").downloadURL(completion: { (url, error) in
                guard let url = url else {
                    completion(.failure(StorageManegerError.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                completion(.success(urlString))
            })
        }
    }
}

