//
//  SearchInteractor.swift
//  ITunesTestTaskVIPER
//
//  Created by Артем Орлов on 31.05.2023.
//

import Foundation

protocol SearchInteractorProtocol {
    func fetchMusic(keyword: String)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func didFetchMusic(_ results: [MusicResult])
    func didFailToFetchMusic(_ error: Error)
}

class SearchInteractor: SearchInteractorProtocol {
    weak var presenter: SearchInteractorOutputProtocol?
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchMusic(keyword: String) {
        networkService.fetchMusic(keyword: keyword) { [weak self] result in
            switch result {
            case .success(let musicResults):
                self?.presenter?.didFetchMusic(musicResults)
            case .failure(let error):
                self?.presenter?.didFailToFetchMusic(error)
            }
        }
    }
}

