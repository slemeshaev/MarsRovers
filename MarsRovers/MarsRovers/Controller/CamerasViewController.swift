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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
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
    
    // метод создания composition layout
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            // ячейка
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            // группа
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(84))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 10, bottom: 8, trailing: 0)
            // секция
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
            
            return section
        }
        return layout
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CamerasViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: 64)
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
        cell.layer.borderWidth = 1
        return cell
    }
    
}
