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
        
        //let camerasVC = CamerasViewController()
        let camerasVC = PhotoViewController()
        let settingsVC = SettingsTableViewController()
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        guard let cameraImage = UIImage(systemName: "photo", withConfiguration: boldConfig) else { return }
        guard let settingsImage = UIImage(systemName: "gearshape", withConfiguration: boldConfig) else { return }
        
        // контроллеры
        viewControllers = [
            constructNavController(rootViewController: camerasVC, title: "Камеры", image: cameraImage),
            constructNavController(rootViewController: settingsVC, title: "Настройки", image: settingsImage)
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
