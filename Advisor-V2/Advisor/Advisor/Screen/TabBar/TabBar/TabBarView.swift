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
    
    func setupTabBarAppearance() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()

            UITabBar.appearance().scrollEdgeAppearance = appearance
            appearance.backgroundColor = .secondarySystemBackground
            appearance.stackedLayoutAppearance.selected.iconColor = .black
        }
//
//        if #available(iOS 15, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
//            appearance.backgroundColor = .white
//
//            UINavigationBar.appearance().standardAppearance = appearance
//            UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        }
    }
    
    func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
    
    func setupViews() {
        viewControllers = [
            createNavController(for: HomeView(), title: "Home", image: UIImage(systemName: "house")!),
            createNavController(for: MapView(), title: "Map", image: UIImage(systemName: "map")!),
            createNavController(for: FavouritesView() , title: "Saved", image: UIImage(systemName: "heart")!)
        ]
    }
}
