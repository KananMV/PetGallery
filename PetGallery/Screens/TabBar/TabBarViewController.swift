//
//  TabBarControllerViewController.swift
//  CarRent
//
//  Created by Kenan Memmedov on 08.09.25.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    private func setupAppearance() {
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .gray
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        setupVC()
    }
    
    private func setupVC() {
        let homeVC = HomeViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeTabIcon"), selectedImage: UIImage(named: "homeTabIconFilled"))
        
        let profileVC = ProfileViewController()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profileIcon"), selectedImage: UIImage(named: "profileIconFilled"))
//
//        let accountVC = AccountViewController()
//        let accountNav = UINavigationController(rootViewController: accountVC)
//        accountNav.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [homeNav, profileNav /*accountNav*/]
        
        
    }

}
