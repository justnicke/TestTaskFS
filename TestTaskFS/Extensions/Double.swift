//
//  Double.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 14.12.2020.
//

import Foundation

extension Double {
    /// Сonverts milliseconds to hours and minutes
    func convertTime() -> String {
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
        
        switch hour {
        case 0:    return String("\(minutes) minutes")
        case 1:    return String("\(hour) hour \(minutes) minutes")
        case 2...: return String("\(hour) hours \(minutes) minutes")
        default:   return String("\(hour) hour \(minutes) minutes")
        }
    }
}
