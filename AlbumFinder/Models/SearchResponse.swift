//
//  SearchResponse.swift
//  AlbumFinder
//
//  Created by PenguinRaja on 19.09.2021.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Album]
}

struct Album: Decodable {
    var wrapperType: String
    var collectionName: String
    var collectionId: Int
    var trackCount: Int
    var artworkUrl100: String?
    var artistName: String
    var trackName: String?
}
