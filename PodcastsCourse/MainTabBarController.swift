//
//  MainTabBarController.swift
//  PodcastsCourse
//
//  Created by 徐冲 on 2018/8/13.
//  Copyright © 2018年 徐冲. All rights reserved.
//

import UIKit


class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        tabBar.tintColor = .purple
        
        setupViewControllers()
    }
    
    //MARK:- Setup Functions
    
    func setupViewControllers() {
        viewControllers = [
            generateNavgationController(for: PodcastsSearchController(), title: "Search", image: #imageLiteral(resourceName: "search")),
            generateNavgationController(for: ViewController(), title: "Favorites", image: #imageLiteral(resourceName: "favorites")),
            generateNavgationController(for: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        ]
    }
    
    //MARK:- Helper Functions
    
    fileprivate func generateNavgationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
//        navController.navigationBar.prefersLargeTitles = true
        // 设置导航头
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
