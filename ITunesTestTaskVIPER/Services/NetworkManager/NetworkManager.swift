//
//  NetworkManager.swift
//  ITunesTestTaskVIPER
//
//  Created by Артем Орлов on 31.05.2023.
//

import Foundation

import UIKit

// Протокол для сервиса работы с сетью
protocol NetworkServiceProtocol {
    func fetchMusic(keyword: String, completion: @escaping (Result<[MusicResult], Error>) -> Void)
}

// Реализация сервиса работы с сетью
class NetworkService: NetworkServiceProtocol {
    func fetchMusic(keyword: String, completion: @escaping (Result<[MusicResult], Error>) -> Void) {
        guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(NetworkError.invalidKeyword))
            return
        }
        
        let urlString = "https://itunes.apple.com/search?term=\(encodedKeyword)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let musicModel = try decoder.decode(MusicModel.self, from: data)
                completion(.success(musicModel.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

// Пример ошибок сетевого сервиса
enum NetworkError: Error {
    case invalidKeyword
    case invalidURL
    case noData
}

// ... Ваш код продолжается здесь

