//
//  MainTabController.swift
//  InstagramClone
//
//  Created by Shridhar Sukhani on 12/31/20.
//

import UIKit

class MainTabController: UITabBarController {
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViewControllers()
    }
    
    // MARK: - Helpers
    func configureViewControllers() {
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"),
                                                selectedImage: #imageLiteral(resourceName: "home_selected"),
                                                rootViewController: FeedController(collectionViewLayout: layout))
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"),
                                                   selectedImage: #imageLiteral(resourceName: "profile_selected"),
                                                   rootViewController: ProfileController())
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"),
                                                  selectedImage: #imageLiteral(resourceName: "search_selected"),
                                                  rootViewController: SearchController())
        let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"),
                                                         selectedImage: #imageLiteral(resourceName: "plus_unselected"),
                                                         rootViewController: ImagePickerController())
        let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"),
                                                         selectedImage: #imageLiteral(resourceName: "like_selected"),
                                                         rootViewController: NotificationController())
        
        viewControllers = [feed, search, imageSelector, notifications, profile]
        tabBar.tintColor = .black
        view.backgroundColor = .white
    }
    
    func templateNavigationController(unselectedImage: UIImage,
                                      selectedImage: UIImage,
                                      rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
}