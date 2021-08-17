//
//  TabBarVC.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 17/08/21.
//

import UIKit

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    private func setupTabBar() {
        let home = HomeRouter()
        let search = SearchRouter()
        home.view.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        search.view.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        self.viewControllers = [home.view, search.view]
    }
}
