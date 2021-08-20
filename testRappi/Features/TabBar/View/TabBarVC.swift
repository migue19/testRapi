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
        home.view.tabBarItem = UITabBarItem(title: "movies".localized, image: UIImage(named: "movie"), tag: 0)
        search.view.tabBarItem = UITabBarItem(title: "search".localized, image: UIImage(named: "search"), tag: 0)
        self.viewControllers = [home.view, search.view]
    }
}
