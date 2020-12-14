//
//  AlbumTrackCell.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 11.12.2020.
//

import UIKit

final class AlbumTrackCell: UICollectionViewCell, CellConfigurable {
    
    // MARK: - Public Properties
    
    static let reuseId = String(describing: AlbumTrackCell.self)
    
    // MARK: - Private Properties
    
    private let trackNumberLabel = UILabel(textColor: .appleGray, font: .avenirNextMedium(16))
    private let trackNameLabel = UILabel(font: .avenirNextMedium(16), numberOfLines: 1)
    private let explicitLabel: UILabel = {
        let label = UILabel(
            textColor: .black,
            font: .avenirNextMedium(10),
            textAlignment: .center
        )
        label.text = "E"
        label.backgroundColor = .lightGray
        label.widthAnchor.constraint(equalToConstant: 13).isActive = true
        label.heightAnchor.constraint(equalToConstant: 13).isActive = true
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true
        return label
    }()
    
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
    
    func configure(_ model: Track) {
        trackNumberLabel.text = String(model.trackNumber ?? 0)
        trackNameLabel.text = model.trackName
        
        switch model.trackExplicitness == "explicit" {
        case true:  explicitLabel.alpha = 1
        case false: explicitLabel.alpha = 0
        }
    }
    
    func setupAutolayout() {
        [trackNumberLabel, trackNameLabel, explicitLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        trackNumberLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        trackNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        trackNumberLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        let priority2 = UILayoutPriority(251)
        trackNameLabel.setContentHuggingPriority(priority2, for: .horizontal)
        trackNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        trackNameLabel.leadingAnchor.constraint(equalTo: trackNumberLabel.trailingAnchor, constant: 7).isActive = true
        
        explicitLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        explicitLabel.leadingAnchor.constraint(equalTo: trackNameLabel.trailingAnchor, constant: 5).isActive = true
        explicitLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20).isActive = true
    }
}
