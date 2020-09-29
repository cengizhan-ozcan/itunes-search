//
//  Search.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

enum ITunes {
    
    enum Request {

    }
    
    enum Response {
        
        struct Search: Codable {
            var resultCount: Int?
            var results: [SearchResult]?
        }
    }
}

