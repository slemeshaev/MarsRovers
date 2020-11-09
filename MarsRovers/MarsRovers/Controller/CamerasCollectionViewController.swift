//
//  CamerasCollectionViewController.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

class CamerasCollectionViewController: UICollectionViewController {
    
    static let reuseIdentifier = "CellId"
    
    var networkDataFetcher = NetworkDataFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .orange
        setupCollectionView()
        self.networkDataFetcher.getImages { (totalResults) in
            totalResults?.photos.map({ (photo) in
                print("Адрес снимка: \(photo.img_src)")
            })
        }
    }
    
    // метод настройки collectionView
    private func setupCollectionView() {
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CamerasCollectionViewController.reuseIdentifier)
    }
    
    // количество ячеек
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // отображение конкретной ячейки
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
}
