//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var wrapperType: WrapperType
    var kind: KindType?
    var trackId: Int?
    var trackName: String?
    var artistName: String
    var collectionName: String?
    var collectionCensoredName: String?
    var trackCensoredName: String?
    var artworkUrl60: String?
    var artworkUrl100: String?
    var artistViewURL: String?
    var collectionViewURL: String?
    var trackViewURL: String?
    var previewUrl: String?
    var trackTimeMillis: Int?
}
