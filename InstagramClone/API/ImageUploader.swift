//
//  ImageUploader.swift
//  InstagramClone
//
//  Created by Shridhar Sukhani on 1/17/21.
//

import UIKit
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(_ image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = UUID().uuidString
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("profile_images/\(filename).jpg")
        
        imageRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else { return }
            print("Successfully uploaded image, metadata:", metadata)
            imageRef.downloadURL { (downloadUrl, err) in
                guard let downloadUrl = downloadUrl?.absoluteString else {
                    print("Error occured while fetching downloadUrl of image:",
                          error?.localizedDescription ?? "nil")
                    return
                }
                
                completion(downloadUrl)
            }
        }
    }
}
