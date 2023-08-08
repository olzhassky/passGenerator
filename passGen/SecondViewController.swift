//
//  SecondViewController.swift
//  passGen
//
//  Created by Olzhas Zhakan on 07.08.2023.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarFunc()
    }
    private func tabBarFunc() {
        var tabBarItem = UITabBarItem()
        let homeIcon = UIImage(systemName: "person.fill")
        tabBarItem = UITabBarItem(title: "Настройки", image: homeIcon, tag: 2)
        self.tabBarItem = tabBarItem
        self.navigationItem.title = "Персонализация"
      //  view.backgroundColor = .systemBackground
    }
}
