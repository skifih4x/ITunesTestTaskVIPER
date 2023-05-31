//
//  MusicPlayerPresenter.swift
//  ITunesTestTaskVIPER
//
//  Created by Артем Орлов on 31.05.2023.
//

import Foundation
import Foundation

protocol MusicPlayerViewProtocol: AnyObject {
    func showMusicDetails(_ musicResult: MusicResult)
}

// ... Ваш код продолжается здесь

class MusicPlayerPresenter {
    weak var view: MusicPlayerViewProtocol?
}

protocol MusicPlayerPresenterProtocol {
    func configure(with musicResult: MusicResult)
}

extension MusicPlayerPresenter: MusicPlayerPresenterProtocol {
    func configure(with musicResult: MusicResult) {
        view?.showMusicDetails(musicResult)
    }
}

