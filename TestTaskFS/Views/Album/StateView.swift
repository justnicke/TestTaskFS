//
//  StateView.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 15.12.2020.
//

import UIKit
import Network

enum SearchingState {
    case empty
    case validResult
    case invalidResult
    case error
}

final class StateView: UIView {
    
    // MARK: - Private Properties
    
    private let textLabel = UILabel(font: .avenirNextBold(17), textAlignment: .center,  numberOfLines: 2)
    private let monitor = NWPathMonitor()
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func currently(_ state: SearchingState) {
        switch state {
        case .empty:
            self.isHidden = false
            textLabel.text = "Let's go!"
        case .validResult:
            self.isHidden = true
        case .invalidResult:
            self.isHidden = false
            textLabel.text = "Album not found."
        case .error:
            self.isHidden = false
            textLabel.text = "Network error."
        }
    }
    
    func networkMonitor() {
        monitor.pathUpdateHandler = { [weak self] path in
            switch path.status == .satisfied {
            case true:  self?.currently(.empty)
            case false: self?.currently(.error)
            }
        }
        monitor.start(queue: DispatchQueue.main)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        addSubview(textLabel)
        textLabel.centerInSuperview(size: .init(width: frame.width, height: 70))
    }
}
