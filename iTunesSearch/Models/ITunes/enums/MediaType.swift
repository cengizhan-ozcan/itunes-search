//
//  MediaType.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

enum MediaType: String, Codable, CaseIterable {
    
    case all = "all"
    case movie = "movie"
    case podcast = "podcast"
    case music = "music"
    
}
