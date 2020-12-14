//
//  AlbumCell.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 10.12.2020.
//

import UIKit
import SDWebImage

final class AlbumCell: UICollectionViewCell, CellConfigurable {
    
    // MARK: - Public Properties
    
    static let reuseId = String(describing: AlbumCell.self)
    
    // MARK: - Private Properties
    
    private let albumImageView = UIImageView(cornerRadius: 10)
    private let albumNameLabel = UILabel(font: .avenirNextMedium(14))
    private let artistNameLabel = UILabel(textColor: .appleGray, font: .avenirNextMedium(13))
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(_ model: Album) {
        guard let url = URL(string: model.artworkUrl100.imageQuality200()) else { return }
        albumImageView.sd_setImage(with: url)
        albumNameLabel.text = model.collectionName
        artistNameLabel.text = model.artistName
    }
    
    func setupAutolayout() {
        [albumImageView, albumNameLabel, artistNameLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        albumImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        albumImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        albumImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        albumImageView.bottomAnchor.constraint(equalTo: albumNameLabel.topAnchor).isActive = true
        albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor, multiplier: 1.0 / 1.0).isActive = true
        
        let priority = UILayoutPriority(252)
        albumNameLabel.setContentHuggingPriority(priority, for: .vertical)
        albumNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor).isActive = true
        albumNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        albumNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        albumNameLabel.bottomAnchor.constraint(equalTo: artistNameLabel.topAnchor).isActive = true
        
        artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor).isActive = true
        artistNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        artistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        artistNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
