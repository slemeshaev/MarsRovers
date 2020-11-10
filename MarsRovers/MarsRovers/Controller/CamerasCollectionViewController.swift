//
//  CamerasCollectionViewController.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

class CamerasViewController: UIViewController {
    
    static let reuseIdentifier = "CellId"
    var collectionView: UICollectionView!
    
    var networkDataFetcher = NetworkDataFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.networkDataFetcher.getImages { (totalResults) in
//            totalResults?.photos.map({ (photo) in
//                print("Адрес снимка: \(photo.img_src)")
//            })
//        }
    }
    
}
