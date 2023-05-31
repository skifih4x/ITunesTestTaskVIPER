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

protocol MusicPlayerPresenterProtocol {
    func configure(with musicResult: MusicResult)
}

final class MusicPlayerPresenter {
    weak var view: MusicPlayerViewProtocol?
}

extension MusicPlayerPresenter: MusicPlayerPresenterProtocol {
    func configure(with musicResult: MusicResult) {
        view?.showMusicDetails(musicResult)
    }
}
