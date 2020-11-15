//
//  NetworkService.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import Foundation

class NetworkService {
    
    // построение запроса данных по URL
    func request(nameRover: String, cameraName: String, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParameters(cameraName: cameraName)
        let url = self.url(nameRover: nameRover, params: parameters)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    // метод создания параметров
    private func prepareParameters(cameraName: String) -> [String: String] {
        var parameters = [String: String]()
        parameters["sol"] = String(1000)
        if cameraName != "" {
            parameters["camera"] = cameraName
        }
        parameters["api_key"] = API.apiKey
        return parameters
    }
    
    // метод создания url
    private func url(nameRover: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = "/mars-photos/api/v1/rovers/\(nameRover)/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
}
