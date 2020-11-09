//
//  MainTabViewController.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        let camerasVC = CamerasCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let settingsVC = SettingsTableViewController()
        
        // контроллеры
        viewControllers = [
            constructNavController(rootViewController: camerasVC, title: "Камеры", image: UIImage(systemName: "photo")!),
            constructNavController(rootViewController: settingsVC, title: "Настройки", image: UIImage(systemName: "gearshape")!)
        ]
        
        // tabbar tintcolor
        tabBar.tintColor = UIColor(red: 109/255, green: 37/255, blue: 251/255, alpha: 1)
        
    }
    
    // метод генерации NavigationController
    private func constructNavController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
    
}
