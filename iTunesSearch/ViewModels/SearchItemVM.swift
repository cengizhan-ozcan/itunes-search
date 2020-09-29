//
//  SearchItemDM.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/22/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

struct SearchItemVM {
    
    private var searchResult: SearchResult
    
    init(searchResult: SearchResult, isSeen: Bool) {
        self.searchResult = searchResult
        self.isSeen = isSeen
    }
    
    var title: String {
        return getTitle()
    }
    var image: String? {
        return searchResult.artworkUrl60
    }
    
    private(set) var isSeen = false
    
    private func getTitle() -> String {
        let trackName = searchResult.trackCensoredName ?? searchResult.trackName ?? "Unknown"
        let artistName = searchResult.artistName
        if let kind = searchResult.kind {
            switch kind {
            case .album, .artistFor, .book, .coachedAudio, .interactiveBooklet, .musicVideo, .song:
                return "\(trackName) - \(artistName)"
            default:
                return "\(trackName)"
            }
        }
        return "Unkown"
    }
    
}
