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
        dateLabel.text = convertDateToDesiredFormat(nameDate: camera.earth_date)
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
            cameraImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.heightAnchor.constraint(equalToConstant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CameraCell {
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
