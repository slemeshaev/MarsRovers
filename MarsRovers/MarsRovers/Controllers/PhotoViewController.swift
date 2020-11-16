//
//  PhotoViewController.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 10.11.2020.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, RoverSnapshot>!
    
    // коллекция фотографий
    private let camera: Camera
    private var photoResults = [RoverSnapshot]()
    
    var networkDataFetcher = NetworkDataFetcher()
    let cameraVC = CamerasViewController()
    
    enum Section: Int, CaseIterable {
        case photos
    }
    
    init(camera: Camera) {
        self.camera = camera
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.networkDataFetcher.getImages(nameRover: cameraVC.nameRover, cameraName: camera.name) { [weak self] (photoRes) in
            guard let fetchedPhotos = photoRes else { return }
            self?.photoResults = fetchedPhotos.photos
            self?.reloadData()
        }
        setupCollectionView()
        createDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(gotNotificationNameRover), name: Notification.Name(rawValue: "notificationFromSettingsVC"), object: nil)
    }
    
    // получение имени ровера
    @objc func gotNotificationNameRover(notification: Notification) {
        guard let userInfo = notification.userInfo, let rover = userInfo["name"] as? String else { return }
        cameraVC.nameRover = rover
    }
    
    // установка collectionView
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        // регистрация заголовка
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        //регистрация ячейки
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
    }
    
    // reloadData
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RoverSnapshot>()
        snapshot.appendSections([.photos])
        snapshot.appendItems(photoResults, toSection: .photos)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
}

extension PhotoViewController {
    // метод createDataSource
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, RoverSnapshot>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, photo) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Неизвестный вид секции")
            }
            switch section {
            case .photos:
                return self.configure(collectionView: collectionView, cellType: PhotoCell.self, with: photo, for: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { fatalError("Невозможно создать header") }
            sectionHeader.configure(camera: self.camera, delegate: self)
            self.navigationItem.title = "Камеры"
            return sectionHeader
        }
    }
}

extension PhotoViewController {
    // метод создания composition layout
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Неизвестный вид секции")
            }
            
            switch section {
            case .photos:
                return self.createPhotosSection()
            }
        }
        // настраиваем расстояние между секциями
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    // метод создания секции для фоток
    private func createPhotosSection() -> NSCollectionLayoutSection {
        // ячейка
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // группа
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(15)
        group.interItemSpacing = .fixed(spacing)
        // секция
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 15, bottom: 0, trailing: 15)
        // заголовок
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
}

extension PhotoViewController: HeaderDelegate {
    func did(select camera: Camera) {
        print(camera)
    }
}
