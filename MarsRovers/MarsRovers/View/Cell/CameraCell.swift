//
//  CameraCell.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

class CameraCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "CameraCellId"
    
    // свойства
    let cameraImageView = UIImageView()
    let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
        setupConstraints()
    }
    
    // метод конфигурации ячейки
    func configure<U>(with value: U) where U : Hashable {
        guard let camera: MImage = value as? MImage else { return }
        cameraImageView.image = UIImage(named: camera.snapshot)
        dateLabel.text = camera.date
    }
    
    // метод установки констрейнтов
    private func setupConstraints() {
        cameraImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cameraImageView)
        
        NSLayoutConstraint.activate([
            cameraImageView.topAnchor.constraint(equalTo: self.topAnchor),
            cameraImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cameraImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cameraImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

