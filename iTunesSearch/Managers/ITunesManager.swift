//
//  ITunesManager.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

class ITunesManager {
    
    private var service: ServiceDelegate!
    
    init(service: ServiceDelegate = MainService.shared) {
        self.service = service
    }
    
    func search(term: String, media: MediaType, limit: Int,
                completion: @escaping (_ result: Result<ITunes.Response.Search, APIError>) -> Void) {
        service.invalidate()
        service.send(api: .search(term: term, media: media, limit: limit)) { (result) in
            completion(result)
        }
    }
    
    func invalidateSearch() {
        service.invalidate()
    }
}
