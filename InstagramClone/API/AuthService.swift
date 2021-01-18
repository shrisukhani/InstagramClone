//
//  AuthService.swift
//  InstagramClone
//
//  Created by Shridhar Sukhani on 1/17/21.
//

import UIKit
import Firebase

struct AuthCredentials {
    var email: String
    var password: String
    var fullname: String
    var username: String
    var profilePicture: UIImage
}

struct AuthService {
    static func registerUser(withCredentials credentials: AuthCredentials,
                             completion: @escaping (Error?) -> Void) {
        ImageUploader.uploadImage(credentials.profilePicture) { profilePictureUrl in
            Auth.auth().createUser(withEmail: credentials.email,
                                   password: credentials.password) { (result, error) in
                if let error = error {
                    print("DEBUG: Failed to register user: \(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else { return }
                let data: [String: Any] = [
                    "email": credentials.email,
                    "fullname": credentials.fullname,
                    "profile_picture_url": profilePictureUrl,
                    "uid": uid,
                    "username": credentials.username
                ]
                
                Firestore.firestore()
                    .collection("users")
                    .document(uid)
                    .setData(data, completion: completion)
            }
        }
    }
}
