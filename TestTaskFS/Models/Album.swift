//
//  Album.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 10.12.2020.
//

import Foundation

struct AlbumResult: Decodable {
    let albums: [Album]
    
    enum CodingKeys: String, CodingKey {
        case albums = "results"
    }
}

struct Album: Decodable {
    let collectionId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let trackCount: Int
    let copyright: String
    let releaseDate: String
    let primaryGenreName: String
}
