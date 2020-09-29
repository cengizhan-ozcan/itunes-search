//
//  WrapperEnum.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

enum WrapperType: String, Codable {
    
    case track = "track"
    case collection = "collection"
    case artistFor = "artistFor"
    case audiobook = "audiobook"
}
