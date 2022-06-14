//
//  TabBarView.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import UIKit

class TabBarView: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTabBarAppearance()
        setupViews()
    }

    let tabBarTintColor = UIColor(named: "tabBarTint")
    
    func setupTabBarAppearance() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()

            UITabBar.appearance().scrollEdgeAppearance = appearance
            appearance.backgroundColor = .secondarySystemBackground
            appearance.stackedLayoutAppearance.selected.iconColor = tabBarTintColor
        }
    }
    
    func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        navController.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navController.navigationBar.tintColor = .black
        tabBar.tintColor = tabBarTintColor
        return navController
    }
    
    func setupViews() {
        viewControllers = [
            createNavController(for: HomeView(), title: "Home", image: UIImage(systemName: "house.fill")!),
            createNavController(for: MapView(), title: "Map", image: UIImage(systemName: "globe.europe.africa.fill")!),
            createNavController(for: FavouritesView() , title: "Saved", image: UIImage(systemName: "bolt.heart.fill")!)
        ]
    }
}
