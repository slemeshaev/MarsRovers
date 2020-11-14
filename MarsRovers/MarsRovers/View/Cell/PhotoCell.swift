//
//  PhotoCell.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 10.11.2020.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "PhotoCell"
    
    let photoImageView = UIImageView()
    let photoDate = UILabel()
    let containerView = UIView()
    
    // метод конфигурации ячейки
    func configure<U>(with value: U) where U : Hashable {
        guard let camera: RoverSnapshot = value as? RoverSnapshot else { return }
        let imageUrl = camera.img_src
        photoImageView.kf.setImage(with: URL(string: imageUrl))
        photoDate.text = convertDateToDesiredFormat(nameDate: camera.earth_date)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    // метод установки констрейнтов
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoDate.translatesAutoresizingMaskIntoConstraints = false
        
        photoImageView.backgroundColor = .red
        
        addSubview(containerView)
        containerView.addSubview(photoImageView)
        containerView.addSubview(photoDate)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        NSLayoutConstraint.activate([
            photoDate.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            photoDate.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            photoDate.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            photoDate.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoCell {
    // функция конвертации даты в нужный формат
    func convertDateToDesiredFormat(nameDate: String) -> String {
        var dateComponents = DateComponents()
        
        let day = nameDate[8..<nameDate.count]
        dateComponents.day = Int(day)
        let month = nameDate[5..<nameDate.count-3]
        dateComponents.month = Int(month)
        let year = nameDate[0..<nameDate.count-6]
        dateComponents.year = Int(year)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        dateFormatter.dateFormat = "d MMMM Y"
        
        let calenader = Calendar.current
        guard let date = calenader.date(from: dateComponents) else {
            return "Ошибка в получении даты!"
        }
        return dateFormatter.string(from: date)
    }
}
