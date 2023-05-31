//
//  SearchPresenter.swift
//  ITunesTestTaskVIPER
//
//  Created by Артем Орлов on 31.05.2023.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showMusicResults(_ results: [MusicResult])
}

protocol SearchPresenterProtocol {
    func searchMusic(_ keyword: String)
    func showMusicPlayer(with musicResult: MusicResult)
}

final class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    
    func searchMusic(_ keyword: String) {
        view?.showLoading()
        interactor?.fetchMusic(keyword: keyword)
    }
    
    func showMusicPlayer(with musicResult: MusicResult) {
        router?.presentMusicPlayerScreen(with: musicResult)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func didFetchMusic(_ results: [MusicResult]) {
        view?.hideLoading()
        view?.showMusicResults(results)
    }
    
    func didFailToFetchMusic(_ error: Error) {
        view?.hideLoading()
    }
}
