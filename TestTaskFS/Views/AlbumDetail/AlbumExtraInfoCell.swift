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
    
    let trackNumberLabel: UILabel = {
       let label = UILabel()
       label.textAlignment = .left
        label.numberOfLines = 2
       label.text = "2 songs, 5 minutes"
       label.font = UIFont(name: "AvenirNext-Medium", size: 15)
       label.textColor = .white
       return label
   }()
   
   private let copyrightLabel: UILabel = {
       let label = UILabel()
       label.textAlignment = .left
       label.numberOfLines = 0
       label.text = "℗2017 Young Money Entertainment/Cash Money Records"
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
    
    func configure(album: Album, tracks: [Track]) {
        let sumOfTrackTimeMillis  = tracks.compactMap({ Double($0.trackTimeMillis ?? 0) }).reduce(0, +).convertTime()
        trackNumberLabel.text = "\(String(album.trackCount)) songs, \(sumOfTrackTimeMillis)"
        copyrightLabel.text = album.copyright
    }
        
    func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [trackNumberLabel, copyrightLabel],
                                    axis: .vertical,
                                    spacing: 3,
                                    distribution: .fillEqually)
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension Double {
    /// Сonverts milliseconds to hours and minutes
    func  convertTime() -> String {
        var millisToSeconds = self / 60000
        var hour = 0
        var minutes = 0
        
        for _ in 0...Int(millisToSeconds / 60) {
            if millisToSeconds >= 60 {
                millisToSeconds -= 60
                hour += 1
                minutes = Int(millisToSeconds.rounded())
            } else {
                minutes = Int(millisToSeconds.rounded(.down))
                break
            }
        }
        
        if hour != 0 {
            return String("\(hour) hour \(minutes) minutes")
        } else {
            return String("\(minutes) minutes")
        }
    }
}
