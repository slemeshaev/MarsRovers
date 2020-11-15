//
//  CamerasViewController.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

class CamerasViewController: UIViewController {

    //cameras = ["FHAZ", "RHAZ", "MAST", "CHEMCAM", "MAHLI", "MARDI", "NAVCAM", "PANCAM", "MINITES"]
    enum Section: Int, CaseIterable {
        case fhaz, rhaz, mast, chemcam, mahli, mardi, navcam, pancam, minites
        
        func description() -> String {
            switch self {
            case .fhaz:
                return "Камера 1"
            case .rhaz:
                return "Камера 2"
            case .mast:
                return "Камера 3"
            case .chemcam:
                return "Камера 4"
            case .mahli:
                return "Камера 5"
            case .mardi:
                return "Камера 6"
            case .navcam:
                return "Камера 7"
            case .pancam:
                return "Камера 8"
            case .minites:
                return "Камера 9"
            }
        }
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<String, RoverSnapshot>?

    var networkDataFetcher = NetworkDataFetcher()

    // коллекция фотографий
    private var cameras: [Camera] = []
    private var sorted: [String: [RoverSnapshot]] = [:]
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let attributedText = NSMutableAttributedString(string: "СМОТРИМ\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedText.append(NSAttributedString(string: API.rovers[2], attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]))
        label.attributedText = attributedText
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createDataSource()
        self.networkDataFetcher.getImages(nameRover: API.rovers[2], cameraName: "") { [weak self] (result) in
            guard let result = result else { return }
            var cameras: Set<Camera> = []
            var sorted: [String: [RoverSnapshot]] = [:]
            result.photos.forEach {
                cameras.insert($0.camera)
                if var photos = sorted[$0.camera.name] {
                    photos.append($0)
                    sorted[$0.camera.name] = photos
                } else {
                    sorted[$0.camera.name] = [$0]
                }
            }
            self?.cameras = Array(cameras)
            self?.sorted = sorted
            self?.reloadData()
        }
    }
    
    // метод установки заголовка для контроллера
    private func setupTitleCollectionView() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // метод установки collectionView
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        // заголовок для коллекции
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(nameLabel)
        // констрейнты для заголовка
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 80),
            nameLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 10)
        ])
        // регистрация заголовка
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        // регистрация ячейки
        collectionView.register(CameraCell.self, forCellWithReuseIdentifier: CameraCell.reuseId)
    }
    
    // метод создания createDataSource
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<String, RoverSnapshot>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, image) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Неизвестный вид секции")
            }
            switch section {
            
            case .fhaz:
                return self.configure(collectionView: collectionView, cellType: CameraCell.self, with: image, for: indexPath)
            case .rhaz:
                return self.configure(collectionView: collectionView, cellType: CameraCell.self, with: image, for: indexPath)
            case .mast:
                return self.configure(collectionView: collectionView, cellType: CameraCell.self, with: image, for: indexPath)
            case .chemcam:
                return self.configure(collectionView: collectionView, cellType: CameraCell.self, with: image, for: indexPath)
            case .mahli:
                return self.configure(collectionView: collectionView, cellType: CameraCell.self, with: image, for: indexPath)
            case .mardi:
                return self.configure(collectionView: collectionView, cellType: CameraCell.self, with: image, for: indexPath)
            case .navcam:
                return self.configure(collectionView: collectionView, cellType: CameraCell.self, with: image, for: indexPath)
            case .pancam:
                return self.configure(collectionView: collectionView, cellType: CameraCell.self, with: image, for: indexPath)
            case .minites:
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
        var snapshot = NSDiffableDataSourceSnapshot<String, RoverSnapshot>()
        let cameras = Array(sorted.keys).sorted()
        snapshot.appendSections(cameras)
        cameras.forEach {
            snapshot.appendItems(sorted[$0] ?? [], toSection: $0)
        }
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
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(160),
                                                   heightDimension: .absolute(130))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
            // секция
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 120, leading: 10, bottom: -100, trailing: 10)
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
