//
//  CamerasViewController.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

class CamerasViewController: UIViewController {

    enum Section: Int, CaseIterable {
        case fhaz, rhaz, mast, chemcam, mahli, mardi, navcam, pancam, minites
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<String, RoverSnapshot>?

    var networkDataFetcher = NetworkDataFetcher()

    // коллекция фотографий
    private var cameras: [Camera] = []
    private var sorted: [String: [RoverSnapshot]] = [:]
    
    // имя марсохода
    var nameRover: String = API.rovers[0]
    var nameLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = nameRover
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        setupCollectionView()
        createDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(gotNotificationIndex), name: Notification.Name(rawValue: "notificationFromSettingsVC"), object: nil)
        self.networkDataFetcher.getImages(nameRover: nameRover, cameraName: "") { [weak self] (result) in
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
    
    // получение индекса
    @objc func gotNotificationIndex(notification: Notification) {
        guard let userInfo = notification.userInfo, let rover = userInfo["name"] as? String else { return }
        nameLabel.text = rover
        nameRover = rover
    }
    
    // метод установки collectionView
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        // заголовок для коллекции
        //nameLabel.translatesAutoresizingMaskIntoConstraints = false
        //collectionView.addSubview(nameLabel)
        // констрейнты для заголовка
//        NSLayoutConstraint.activate([
//            nameLabel.heightAnchor.constraint(equalToConstant: 80),
//            nameLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 10),
//            nameLabel.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 10)
//        ])
        // регистрация заголовка
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        // регистрация ячейки
        collectionView.register(CameraCell.self, forCellWithReuseIdentifier: CameraCell.reuseId)
    }
    
    // метод создания createDataSource
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<String, RoverSnapshot>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, image) -> UICollectionViewCell? in
            return self.configure(collectionView: collectionView, cellType: CameraCell.self, with: image, for: indexPath)
        })
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader,
                  let camera = self.cameras.first(where: {$0.name == Array(self.sorted.keys).sorted()[indexPath.section]}) else { return nil }
            sectionHeader.configure(camera: camera, delegate: self)
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
            group.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0)
            // секция
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 20)
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

extension CamerasViewController: HeaderDelegate {
    func did(select camera: Camera) {
        print(camera)
    }
}
