//
//  SectionHeader.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

protocol HeaderDelegate: class {
    func did(select camera: Camera)
}

class SectionHeader: UICollectionReusableView {
    
    static let reuseId = "SectionHeader"
    
    private var camera: Camera? {
        didSet {
            titleHeader.text = camera?.name ?? ""
            titleHeader.font = .boldSystemFont(ofSize: 20)
        }
    }
    
    private weak var delegate: HeaderDelegate?
    
    let containerView = UIView()
    let titleHeader = UILabel()
    let buttonArrow = UIButton()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        camera = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleHeader.translatesAutoresizingMaskIntoConstraints = false
        buttonArrow.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        containerView.addSubview(titleHeader)
        containerView.addSubview(buttonArrow)
        
        buttonArrow.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        buttonArrow.addTarget(self, action: #selector(showAllPhotos), for: .touchUpInside)
        
        // констрейнты для контейнера
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // устанавливаем констрейнты для заголовка
        NSLayoutConstraint.activate([
            titleHeader.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleHeader.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleHeader.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        
        // устанавливаем констрейнты для кнопки
        NSLayoutConstraint.activate([
            buttonArrow.topAnchor.constraint(equalTo: containerView.topAnchor),
            buttonArrow.leadingAnchor.constraint(equalTo: titleHeader.trailingAnchor, constant: 16),
            buttonArrow.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            buttonArrow.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // функция показать фотографии
    @objc func showAllPhotos() {
        guard let camera = camera else {
            print("Ошибка заголовка камеры")
            return
        }
        delegate?.did(select: camera)
    }
    
    // метод конфигурации ячейки
    func configure(camera: Camera, delegate: HeaderDelegate) {
        self.delegate = delegate
        self.camera = camera
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
