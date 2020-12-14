//
//  Label.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 14.12.2020.
//

import UIKit

extension UILabel {
    /// Custom initializer with default parameters
    /// - Parameters:
    ///   - textColor: white
    ///   - font: UIFont.init(name: "AvenirNext-Medium", size: 15)
    ///   - textAlignment: left
    ///   - numberOfLines: 1
    convenience init(textColor: UIColor = .white,
                     font: UIFont? = .avenirNextMedium(15),
                     textAlignment: NSTextAlignment = .left,
                     numberOfLines: Int = 1) {
        self.init()
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
