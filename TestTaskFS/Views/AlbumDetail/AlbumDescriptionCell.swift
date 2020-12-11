//
//  AlbumDescriptionCell.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 11.12.2020.
//

import UIKit
import SDWebImage

final class AlbumDescriptionCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let reuseId = String(describing: AlbumDescriptionCell.self)
    
    // MARK: - Private Properties
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
     let albumLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Radical - EP"
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.textColor = .white
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "lxst cxntury"
        label.font = UIFont(name: "AvenirNext-Medium", size: 17)
        label.textColor = .white
        return label
    }()
    
    let primaryGenreAndReleaseLabel: UILabel = {
       let label = UILabel()
       label.textAlignment = .center
       label.text = "HIP-HOP/RAP - 2020"
       label.font = UIFont(name: "AvenirNext-Medium", size: 15)
        label.textColor = .white
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
        guard let url = URL(string: album.artworkUrl100.replaceQuality()) else { return }
        albumImageView.sd_setImage(with: url)
        albumLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
        primaryGenreAndReleaseLabel.text = "\(album.primaryGenreName) – \(album.releaseDate.dropLast(album.releaseDate.count - 4))"
 
    }
    
    private func setupUI() {
        let stackView = UIStackView(
            arrangedSubviews: [albumLabel, artistNameLabel, primaryGenreAndReleaseLabel],
            axis: .vertical,
            spacing: 5)
        
        [albumImageView, stackView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        albumImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        albumImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.width / 5.5).isActive = true
        albumImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -frame.width / 5.5).isActive = true
        albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor, multiplier: 1.0 / 1.0).isActive = true
    
        stackView.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
}

extension String {
    func replaceQuality() -> String {
        return self.replacingOccurrences(of: "100x100", with: "400x400")
    }
}
