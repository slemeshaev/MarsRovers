//
//  MainTabViewController.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

class MainTabViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate
        self.delegate = self
        
        // configure view controllers
        configureViewControllers()
    }
    
    // функция для создания контроллера представления
    // который существует в контроллере панели вкладок
    func configureViewControllers() {
        
        // cameras viewcontroller
        let camerasVC = constructNavController(unselectedImage: UIImage(systemName: "photo")!, selectedImage: UIImage(systemName: "photo.fill")!, nameTitle: "Камеры", rootViewController: CamerasCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // settings viewcontroller
        let settingsVC = constructNavController(unselectedImage: UIImage(systemName: "gearshape")!, selectedImage: UIImage(systemName: "gearshape.fill")!, nameTitle: "Настройки", rootViewController: SettingsTableViewController())
        
        // view controller добавляем в tabbar controller
        viewControllers = [camerasVC, settingsVC]
        
        // tabbar tintcolor
        tabBar.tintColor = UIColor(red: 109/255, green: 37/255, blue: 251/255, alpha: 1)
    }
    
    // создать navigation controllers
    func constructNavController(unselectedImage: UIImage, selectedImage: UIImage, nameTitle: String, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        // создаем navigation controller
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = unselectedImage
        navigationController.title = nameTitle
        navigationController.tabBarItem.selectedImage = selectedImage
        navigationController.navigationBar.tintColor = .black
        
        // возвращаем navigation controller
        return navigationController
    }
}
