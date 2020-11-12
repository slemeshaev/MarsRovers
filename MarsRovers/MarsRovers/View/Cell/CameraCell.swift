//
//  CameraCell.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit
import Kingfisher

class CameraCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "CameraCellId"
    
    // свойства
    let cameraImageView = UIImageView()
    let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
        setupConstraints()
    }
    
    // метод конфигурации ячейки
    func configure<U>(with value: U) where U : Hashable {
        guard let camera: RoverSnapshot = value as? RoverSnapshot else { return }
        let imageUrl = camera.img_src
        cameraImageView.kf.setImage(with: URL(string: imageUrl))
        dateLabel.text = camera.earth_date
    }
    
    // метод установки констрейнтов
    private func setupConstraints() {
        cameraImageView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cameraImageView)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            cameraImageView.topAnchor.constraint(equalTo: self.topAnchor),
            cameraImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cameraImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cameraImageView.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.heightAnchor.constraint(equalToConstant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

