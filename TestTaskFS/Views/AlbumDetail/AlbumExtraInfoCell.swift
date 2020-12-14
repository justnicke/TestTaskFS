//
//  AlbumExtraInfoCell.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 11.12.2020.
//

import UIKit

final class AlbumExtraInfoCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let reuseId = String(describing: AlbumExtraInfoCell.self)
    
    // MARK: - Private Properties
    
    private let trackNumberLabel = UILabel(textColor: .appleGray)
    private let copyrightLabel = UILabel(textColor: .appleGray, numberOfLines: 0)

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
    
    func configure(album: Album, tracks: [Track]) {
        let sumOfTrackTimeMillis = tracks
            .compactMap({ Double($0.trackTimeMillis ?? 0) })
            .reduce(0, +)
            .convertTime()
        
        if album.trackCount > 1 {
            trackNumberLabel.text = "\(String(album.trackCount)) songs, \(sumOfTrackTimeMillis)"
        } else {
            trackNumberLabel.text = "\(String(album.trackCount)) song, \(sumOfTrackTimeMillis)"
        }
        
        copyrightLabel.text = album.copyright
    }
    
    func setupAutolayout() {
        let stackView = UIStackView(
            arrangedSubviews: [trackNumberLabel, copyrightLabel],
            axis: .vertical,
            spacing: 3,
            distribution: .fillProportionally
        )
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
