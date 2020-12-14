//
//  ImageView.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 14.12.2020.
//

import UIKit

extension UIImageView {
    /// Custom initializer with default parameters
    /// - Parameters:
    ///   - contentMode: scaleAspectFit
    ///   - backgroundColor: clear
    ///   - cornerRadius: 0.0
    ///   - masksToBounds: true
    convenience init(contentMode: UIView.ContentMode = .scaleAspectFit,
                     backgroundColor: UIColor? = .clear,
                     cornerRadius: CGFloat,
                     masksToBounds: Bool = true) {
        self.init()
        self.contentMode = contentMode
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = masksToBounds
    }
}
