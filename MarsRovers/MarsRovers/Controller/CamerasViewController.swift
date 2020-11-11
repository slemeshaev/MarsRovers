//
//  CamerasViewController.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

// тестовая модель данных
struct MImage: Hashable, Decodable {
    var snapshot: String
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

    enum Section: Int, CaseIterable {
        case camera1, camera2
        
        func description() -> String {
            switch self {
            case .camera1:
                return "Камера 1"
            case .camera2:
                return "Камера 2"
            }
        }
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, MImage>?

    var networkDataFetcher = NetworkDataFetcher()
    
    // массивы с фотками
    let cameraOneImages = Bundle.main.decode([MImage].self, from: "cameraImages.json")
    let cameraTwoImages = Bundle.main.decode([MImage].self, from: "cameraAnotherImages.json")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createDataSource()
        reloadData()
        
        self.networkDataFetcher.getImages(nameRover: "spirit") { (allResults) in
            allResults?.photos.map({ (photo) in
                print(photo.earth_date)
            })
        }
    }
    
    // метод установки collectionView
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        // регистрация заголовка
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        // регистрация ячейки
        collectionView.register(CameraCell.self, forCellWithReuseIdentifier: CameraCell.reuseId)
    }
    
    //
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MImage>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, image) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Неизвестный вид секции")
            }
            switch section {
            case .camera1:
                return self.configure(collectionView: collectionView, cellType: CameraCell.self, with: image, for: indexPath)
            case .camera2:
                return self.configure(collectionView: collectionView, cellType: CameraCell.self, with: image, for: indexPath)
            }
        })
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { fatalError("Невозможно создать header") }
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Неизвестный вид секции") }
            sectionHeader.configure(text: section.description(), font: .boldSystemFont(ofSize: 20))
            
            self.navigationItem.title = "Камеры"
            return sectionHeader
        }
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MImage>()
        snapshot.appendSections([.camera1, .camera2])
        snapshot.appendItems(cameraOneImages, toSection: .camera1)
        snapshot.appendItems(cameraTwoImages, toSection: .camera2)
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
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120),
                                                   heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 10, bottom: 8, trailing: 0)
            // секция
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 0, trailing: 10)
            section.orthogonalScrollingBehavior = .continuous
            // заголовок
            let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                           heightDimension: .estimated(1))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }
        
        // настраиваем расстояние между секциями
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CamerasViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: 64)
    }
}
