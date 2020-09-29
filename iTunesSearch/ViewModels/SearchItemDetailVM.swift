//
//  SearchItemDetailVM.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/23/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

enum SearchItemTitleType: String {
    
    case trackName = "Track Name"
    case artistName = "Artist Name"
    case collectionName = "Collection Name"
    case kind = "Kind"
    
}

struct SearchItemDetailVM {
    
    private var searchResult: SearchResult
    private var titleType: SearchItemTitleType
    
    init(searchResult: SearchResult, titleType: SearchItemTitleType) {
        self.searchResult = searchResult
        self.titleType = titleType
    }
    
    var title: String {
        get {
            return self.titleType.rawValue
        }
    }
    
    var content: String {
        switch titleType {
        case .trackName:
            return searchResult.trackName ?? "-"
        case .artistName:
            return searchResult.artistName
        case .collectionName:
            return searchResult.collectionCensoredName ?? searchResult.collectionName ?? "-"
        case .kind:
            return searchResult.kind?.value ?? "-"
        }
    }
}
