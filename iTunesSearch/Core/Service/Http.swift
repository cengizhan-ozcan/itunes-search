//
//  Http.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

struct Http {
    
    var path: String
    var method: HttpMethod
    var body: Data?
    
}

enum HttpMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
}
