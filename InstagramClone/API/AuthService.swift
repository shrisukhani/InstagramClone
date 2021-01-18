//
//  AuthService.swift
//  InstagramClone
//
//  Created by Shridhar Sukhani on 1/17/21.
//

import UIKit

struct AuthCredentials {
    var email: String
    var password: String
    var fullname: String
    var username: String
    var profilePicture: UIImage
}

struct AuthService {
    static func registerUser(withCredentials credentials: AuthCredentials) {
        print(credentials.email)
    }
}
