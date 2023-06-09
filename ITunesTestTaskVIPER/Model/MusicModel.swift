//
//  MusicModel.swift
//  ITunesTestTaskVIPER
//
//  Created by Артем Орлов on 31.05.2023.
//

struct MusicModel: Codable {
    let results: [MusicResult]
}

struct MusicResult: Codable {
    let artistName, collectionName: String
    let trackName: String?
    let previewUrl: String?
    let artworkUrl100: String
}
