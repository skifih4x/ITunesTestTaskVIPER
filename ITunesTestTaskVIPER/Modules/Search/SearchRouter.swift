//
//  SearchRouter.swift
//  ITunesTestTaskVIPER
//
//  Created by Артем Орлов on 31.05.2023.
//

import UIKit

protocol SearchRouterProtocol {
    func presentMusicPlayerScreen(with musicResult: MusicResult)
}

final class SearchRouter: SearchRouterProtocol {
    weak var viewController: SearchViewController?
    
    static func createModule() -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresenter()
        let interactor = SearchInteractor(networkService: NetworkService())
        let router = SearchRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func presentMusicPlayerScreen(with musicResult: MusicResult) {
        let musicPlayerViewController = MusicPlayerViewController(musicResult: musicResult)
        viewController?.navigationController?.pushViewController(musicPlayerViewController, animated: true)
    }
}
