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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CamerasViewController.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        self.networkDataFetcher.getImages { (totalResults) in
//            totalResults?.photos.map({ (photo) in
//                print("Адрес снимка: \(photo.img_src)")
//            })
//        }
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CamerasViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CamerasViewController.reuseIdentifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
}
