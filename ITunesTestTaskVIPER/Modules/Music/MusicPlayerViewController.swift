//
//  MusicPlayerViewController.swift
//  ITunesTestTaskVIPER
//
//  Created by Артем Орлов on 31.05.2023.
//

import UIKit

class MusicPlayerViewController: UIViewController {
    private let coverImageView = UIImageView()
    private let artistLabel = UILabel()
    private let trackLabel = UILabel()
    
    private let musicResult: MusicResult
    
    init(musicResult: MusicResult) {
        self.musicResult = musicResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure(with: musicResult)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coverImageView)
        
        NSLayoutConstraint.activate([
            coverImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coverImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            coverImageView.widthAnchor.constraint(equalToConstant: 200),
            coverImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artistLabel)
        
        NSLayoutConstraint.activate([
            artistLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            artistLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 16)
        ])
        
        trackLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trackLabel)
        
        NSLayoutConstraint.activate([
            trackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 8)
        ])
    }
    
    private func configure(with musicResult: MusicResult) {
        coverImageView.image = UIImage(named: "placeholder_image") // Placeholder image
        artistLabel.text = musicResult.artistName
        trackLabel.text = musicResult.trackName ?? musicResult.collectionName
    }
}

