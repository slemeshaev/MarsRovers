//
//  NetworkDataFetcher.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 10.11.2020.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    // метод получения картинок
    func getImages(completion: @escaping (SnapshotsResults?) -> ()) {
        networkService.request(nameRover: "curiosity") { (data, error) in
            if let error = error {
                print("Получение данных завершилось ошибкой \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: SnapshotsResults.self, from: data)
            completion(decode)
        }
    }
    
    // декодируем данные JSON
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Ошибка декодирования данных JSON \(jsonError)")
            return nil
        }
    }
    
}
