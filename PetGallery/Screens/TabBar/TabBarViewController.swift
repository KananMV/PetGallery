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
        
        let favoritesVC = FavoritesViewController()
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        favoritesNav.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favoritesTabIcon"), selectedImage: UIImage(named: "favoritesTabIconFilled"))
      
        
        viewControllers = [homeNav, favoritesNav, profileNav]
        
        
    }

}
