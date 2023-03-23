//
//  MainTabBarController.swift
//  Countries
//
//  Created by Ömer Karabulut on 20.03.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let vc1 = RootNavigationController(rootViewController: HomeViewController())
        let vc2 = RootNavigationController(rootViewController: SavedViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        vc1.tabBarItem.title = "Home"
        vc2.tabBarItem.title = "Saved"
        
        setViewControllers([vc1, vc2], animated: true)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.darkGray
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.black
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        self.tabBar.tintColor = .white
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }
}
