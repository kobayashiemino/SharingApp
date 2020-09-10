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
    
    private let bucket = Storage.storage().reference()
    
    enum StorageManegerError: Error {
        case failedToDownload
    }
    
    public func uploadImage(model: UserPost, completion: (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, StorageManegerError>) -> Void) {
        bucket.child(reference).downloadURL { (url, error) in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        }
    }
}

