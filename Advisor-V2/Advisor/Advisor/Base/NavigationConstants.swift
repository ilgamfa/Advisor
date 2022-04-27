//
//  NavigationConstants.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import Foundation

public enum Screen {
    public enum Name: String, CaseIterable {
        case home = "HomeView"
        case categoriesView = "CategoriesView"
        case cart = "CartView"
        case wishlist = "WishlistView"
        case profile = "ProfileView"
        case tabBar = "TabBarView"
        case productView = "ProductView"
        case categoryProductsView = "CategoryProductsView"
    }
}

