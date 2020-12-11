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
    
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
