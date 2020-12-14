//
//  StackView.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 11.12.2020.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis = .vertical,
                     spacing: CGFloat = 0,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill) {
        
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
}
