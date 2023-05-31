//
//  MusicPlayerViewController.swift
//  ITunesTestTaskVIPER
//
//  Created by Артем Орлов on 31.05.2023.
//

import UIKit
import AVFoundation

final class MusicPlayerViewController: UIViewController {
    private let coverImageView = UIImageView()
    private let artistLabel = UILabel()
    private let trackLabel = UILabel()
    private let playButton = UIButton()
    
    private let musicResult: MusicResult
    
    private var player: AVPlayer?
    
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
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("Play", for: .normal)
        playButton.setTitle("Stop", for: .selected)
        playButton.setTitleColor(.blue, for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        view.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: trackLabel.bottomAnchor, constant: 16)
        ])
    }
    
    private func configure(with musicResult: MusicResult) {
        artistLabel.text = musicResult.artistName
        trackLabel.text = musicResult.trackName ?? musicResult.collectionName
        
        guard let imageURL = URL(string: musicResult.artworkUrl100) else {
            coverImageView.image = UIImage(named: "placeholder_image")
            return
        }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async { [weak self] in
                    self?.coverImageView.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    @objc private func playButtonTapped() {
        if playButton.isSelected {
            player?.pause()
        } else {
            guard let previewURLString = musicResult.previewUrl, let previewURL = URL(string: previewURLString) else {
                return
            }
            
            player = AVPlayer(url: previewURL)
            player?.play()
        }
        
        playButton.isSelected = !playButton.isSelected
    }
}
