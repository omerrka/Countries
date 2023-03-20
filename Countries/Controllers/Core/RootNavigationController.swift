//
//  RootNavigationController.swift
//  Countries
//
//  Created by Aybike Zeynep Tiryaki on 20.03.2023.
//

import UIKit

final class RootNavigationController: UINavigationController {
  
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        
    }
    
    private func setUpNavigation() {
        
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemGray3
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 18.0), .foregroundColor: UIColor.black]
        
        self.navigationBar.tintColor = .black
        self.navigationBar.standardAppearance = appearance
        
    }
}


