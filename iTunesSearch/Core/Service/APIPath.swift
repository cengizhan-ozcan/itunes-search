//
//  APIPath.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

enum API {
    
    case search(term: String, media: MediaType, limit: Int)
    
    var endpoint: (path: String, method: HttpMethod) {
        switch self {
        case .search(let term, let media, let limit):
            let path = "search?term=\(term)&media=\(media.rawValue)&limit=\(limit)"
            return (path, .get)
        }
    }
}
