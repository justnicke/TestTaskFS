//
//  Track.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 11.12.2020.
//

import Foundation

struct TrackResult: Decodable {
    var tracks: [Track]
    
    enum CodingKeys: String, CodingKey {
        case tracks = "results"
    }
}

struct Track: Decodable {
    let trackName: String?
    let trackExplicitness: String?
    let trackNumber: Int?
    let trackTimeMillis: Int?
}
