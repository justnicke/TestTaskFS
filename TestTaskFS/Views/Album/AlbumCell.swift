//
//  AlbumCell.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 10.12.2020.
//

import UIKit
import SDWebImage

final class AlbumCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let reuseId = String(describing: AlbumCell.self)
    
    // MARK: - Private Properties
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
     let albumLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Radical - EP"
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "lxst cxntury"
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        label.textColor = .systemGray
        return label
    }()
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(album: Album) {
        guard let url = URL(string: album.artworkUrl100) else { return }
        albumImageView.sd_setImage(with: url)
        albumLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
    }
    
    private func setupUI() {
        [albumImageView, albumLabel, artistNameLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        albumImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        albumImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        albumImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        albumImageView.bottomAnchor.constraint(equalTo: albumLabel.topAnchor).isActive = true
        albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor, multiplier: 1.0 / 1.0).isActive = true
        
        let priority = UILayoutPriority(252)
        albumLabel.setContentHuggingPriority(priority, for: .vertical)
        albumLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor).isActive = true
        albumLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        albumLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        albumLabel.bottomAnchor.constraint(equalTo: artistNameLabel.topAnchor).isActive = true
        
        artistNameLabel.topAnchor.constraint(equalTo: albumLabel.bottomAnchor).isActive = true
        artistNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        artistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        artistNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

