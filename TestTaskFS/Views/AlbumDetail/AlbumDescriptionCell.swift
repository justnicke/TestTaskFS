//
//  AlbumDescriptionCell.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 11.12.2020.
//

import UIKit
import SDWebImage

final class AlbumDescriptionCell: UICollectionViewCell, CellConfigurable {
    
    // MARK: - Public Properties
    
    static let reuseId = String(describing: AlbumDescriptionCell.self)
    
    // MARK: - Private Properties
    
    private let albumImageView = UIImageView(cornerRadius: 10)
    private let albumNameLabel = UILabel(font: .avenirNextBold(18), textAlignment: .center, numberOfLines: 0)
    private let artistNameLabel = UILabel(textColor: .appleRed, font: .avenirNextMedium(17), textAlignment: .center, numberOfLines: 2)
    private let primaryGenreAndReleaseLabel = UILabel(textColor: .appleGray, font: .avenirNextMedium(14), textAlignment: .center)
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        setupAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(_ model: Album) {
        guard let url = URL(string: model.artworkUrl100.imageQuality400()) else { return }
        albumImageView.sd_setImage(with: url)
        albumNameLabel.text = model.collectionName
        artistNameLabel.text = model.artistName
        primaryGenreAndReleaseLabel.text = "\(model.primaryGenreName.uppercased()) – \(model.releaseDate.prefix(4))"
    }
    
    func setupAutolayout() {
        let stackView = UIStackView(
            arrangedSubviews: [albumNameLabel, artistNameLabel, primaryGenreAndReleaseLabel],
            axis: .vertical,
            spacing: 5
        )
        
        [albumImageView, stackView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        albumImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        albumImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.width / 5.5).isActive = true
        albumImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -frame.width / 5.5).isActive = true
        albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor, multiplier: 1.0 / 1.0).isActive = true

        stackView.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}
