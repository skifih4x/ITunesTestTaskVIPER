//
//  MusicPlayerInteractor.swift
//  ITunesTestTaskVIPER
//
//  Created by Артем Орлов on 31.05.2023.
//

import Foundation

protocol MusicPlayerInteractorProtocol {
    func getMusicResult() -> MusicResult
}

final class MusicPlayerInteractor {
    let musicResult: MusicResult
    
    init(musicResult: MusicResult) {
        self.musicResult = musicResult
    }
}

extension MusicPlayerInteractor: MusicPlayerInteractorProtocol {
    func getMusicResult() -> MusicResult {
        return musicResult
    }
}
