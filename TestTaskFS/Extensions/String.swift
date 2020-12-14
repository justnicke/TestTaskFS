//
//  String.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 14.12.2020.
//

import Foundation

extension String {
    func imageQuality200() -> String {
        return self.replacingOccurrences(of: "100x100", with: "200x200")
    }
    
    func imageQuality400() -> String {
        return self.replacingOccurrences(of: "100x100", with: "400x400")
    }
    
    func removeSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
