//
//  SearchCell.swift
//  ITunesTestTaskVIPER
//
//  Created by Артем Орлов on 31.05.2023.
//

import UIKit

final class SearchCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SearchCell"
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    // MARK: - Configuration
    
    func configure(with musicResult: MusicResult) {
        trackNameLabel.text = musicResult.trackName
        artistNameLabel.text = musicResult.artistName
        
        if let coverURL = URL(string: musicResult.artworkUrl100) {
            coverImageView.loadImage(from: coverURL, placeholder: UIImage(named: "placeholder_image"))
        }
    }
    
    // MARK: - UI Setup
    
    private func setupViews() {
        
        coverImageView.layer.cornerRadius = 10
        
        addSubview(coverImageView)
        addSubview(trackNameLabel)
        addSubview(artistNameLabel)
        
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            coverImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            coverImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            coverImageView.widthAnchor.constraint(equalTo: coverImageView.heightAnchor),
            
            trackNameLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8),
            trackNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            trackNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            artistNameLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8),
            artistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 4),
            artistNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
