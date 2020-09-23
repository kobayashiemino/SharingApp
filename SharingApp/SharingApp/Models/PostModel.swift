//
//  postModel.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/12.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import UIKit

public struct Post {
    let title: String
    let itemSiteURL: String
    let imageURL: String
    let caption: String
    let uploadedDate: String
    let category: String
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.itemSiteURL = dictionary["itemSiteURL"] as? String ?? ""
        self.imageURL = dictionary["imageURL"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.uploadedDate = dictionary["uploadedDate"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
    }
}

public struct Profile {
    let username: String
    let email: String
    let password: String
    let profilePicture: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.profilePicture = dictionary["profilePicture"] as? String ?? ""
    }
}

public struct Category {
    let category: String
    let newCategory: String
}

public struct Brand {
    let brand: String
}
