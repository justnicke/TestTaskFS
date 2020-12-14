//
//  CellConfigurable.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 14.12.2020.
//

import Foundation

protocol CellConfigurable {
    associatedtype AnyCellModel
    ///sfgsrg
    func configure(_ model: AnyCellModel)
    func setupAutolayout()
}
