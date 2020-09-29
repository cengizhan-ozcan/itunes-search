//
//  ItemDetailInteractor.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/23/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

class ItemDetailInteractor {
    
    var presenter: IPItemDetailProtocol?
    
}

extension ItemDetailInteractor: PIItemDetailProtocol {
    
    func addSeachItemToDeletedList(with item: SearchResult) {
        guard let trackId = item.trackId, let trackName = item.trackName else {
                   return
        }
        SearchDataSource.shared.addNewDeletedItem(for: "\(trackId)-\(trackName)-\(item.artistName)")
    }
}
