//
//  AlbumTrackCell.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 11.12.2020.
//

import UIKit

final class AlbumTrackCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let reuseId = String(describing: AlbumTrackCell.self)
    
    // MARK: - Private Properties
    
    let trackNumberLabel: UILabel = {
       let label = UILabel()
       label.textAlignment = .left
       label.text = "2"
       label.font = UIFont(name: "AvenirNext-Medium", size: 16)
       label.textColor = .white
       return label
   }()
   
   private let trackNameLabel: UILabel = {
       let label = UILabel()
       label.textAlignment = .left
    label.numberOfLines = 1
       label.text = "Amnesia"
       label.font = UIFont(name: "AvenirNext-Medium", size: 16)
       label.textColor = .white
       return label
   }()
    
    private let explicitLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "E"
        label.font = UIFont(name: "AvenirNext-Medium", size: 10)
        label.textColor = .black
        label.widthAnchor.constraint(equalToConstant: 14).isActive = true
        label.heightAnchor.constraint(equalToConstant: 14).isActive = true
        label.backgroundColor = .lightGray
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
    
    func configure(track: Track) {
        trackNumberLabel.text = String(track.trackNumber ?? 0)
        trackNameLabel.text = track.trackName
        
        if track.trackExplicitness == "explicit" {
            explicitLabel.alpha = 1
        } else {
            explicitLabel.alpha = 0
        }
    }
    
    private func setupUI() {
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
