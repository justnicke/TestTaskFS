//
//  AlbumDescriptionCell.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 11.12.2020.
//

import UIKit

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
    
    let primaryGenreAndYearLabel: UILabel = {
       let label = UILabel()
       label.textAlignment = .left
       label.text = "Radical - EP"
       label.font = UIFont(name: "AvenirNext-Medium", size: 14)
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
    
    func setupUI() {
        
    }
}
