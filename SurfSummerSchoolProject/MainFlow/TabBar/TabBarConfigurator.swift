//
//  TabBarConfigurator.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 03.08.2022.
//

import Foundation
import UIKit

class TabBarConfigurator {
    
    // MARK: - Private Properties
    
    private let allTab: [TabBarModel] = [.main, .favorites, .profile]
    
    
    // MARK: - Private Methods
    
    func configur() -> UITabBarController {
        return getTabBarController()
    }
}

private extension TabBarConfigurator {
    
    func getTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = getConrollers()
        return tabBarController
    }
    
    func getConrollers() -> [UIViewController] {
        
        var viewControllers = [UIViewController]()
        
        allTab.forEach { tab in
            let controller = getCurentViewController(tab: tab )
            let navController = UINavigationController(rootViewController: controller)
            let tabBarItem = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)
            controller.title = tab.title
            controller.tabBarItem = tabBarItem
            
            viewControllers.append(navController)
        }
        
        return viewControllers
    } 
    
    func getCurentViewController(tab: TabBarModel) -> UIViewController  {
        switch tab {
        case .main:
            return MainViewController()
        case .favorites:
            return FavoritesViewController()
        case .profile:
            return ProfileViewController()
        }
    }

}
