//
//  CamerasViewController.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

struct MImage: Hashable {
    var snapshot: UIImage
    var date: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MImage, rhs: MImage) -> Bool {
        return lhs.id == rhs.id
    }
}

class CamerasViewController: UIViewController {
    
    static let reuseIdentifier = "CellId"
    
    enum Section: Int, CaseIterable {
        case camera
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, MImage>?
    
    var networkDataFetcher = NetworkDataFetcher()
    
    // массив картинок
    let imagesRover: [MImage] = [
        MImage(snapshot: UIImage(named: "image1")!, date: "2020-12-12", id: 1),
        MImage(snapshot: UIImage(named: "image2")!, date: "2010-02-14", id: 2),
        MImage(snapshot: UIImage(named: "image3")!, date: "2018-08-16", id: 3),
        MImage(snapshot: UIImage(named: "image4")!, date: "2017-03-19", id: 4)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createDataSource()
        reloadData()
        
//        self.networkDataFetcher.getImages { (totalResults) in
//            totalResults?.photos.map({ (photo) in
//                print("Адрес снимка: \(photo.img_src)")
//            })
//        }
    }
    
    // метод установки collectionView
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CamerasViewController.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MImage>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, image) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Неизвестный вид секции")
            }
            switch section {
            case .camera:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CamerasViewController.reuseIdentifier, for: indexPath)
                cell.backgroundColor = .systemBlue
                return cell
            }
            
        })
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MImage>()
        snapshot.appendSections([.camera])
        snapshot.appendItems(imagesRover, toSection: .camera)
        dataSource?.apply(snapshot, animatingDifferences: true)
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
