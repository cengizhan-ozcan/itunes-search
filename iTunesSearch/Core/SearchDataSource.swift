//
//  SearchDataSource.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/22/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

struct SearchDataSource {
    
    static let shared = SearchDataSource()
    private init() {}
    
    private let SEEN_ITEMS_KEY = "SeenItemIds"
    private let DELETED_ITEMS_KEY = "DeletedItemIds"
    
    var seenItemIdList: [String] {
        get {
            return UserDefaults.standard.array(forKey: SEEN_ITEMS_KEY) as? [String] ?? []
        }
    }
    
    var deletedItemIdList: [String] {
        get {
            return UserDefaults.standard.array(forKey: DELETED_ITEMS_KEY) as? [String] ?? []
        }
    }
    
    func addNewSeenItem(for id: String) {
        if !seenItemIdList.contains(id) {
            var items = UserDefaults.standard.array(forKey: SEEN_ITEMS_KEY) as? [String] ?? []
            items.append(id)
            UserDefaults.standard.setValue(items, forKey: SEEN_ITEMS_KEY)
        }
    }
    
    func addNewDeletedItem(for id: String) {
        if !deletedItemIdList.contains(id) {
            var items = UserDefaults.standard.array(forKey: DELETED_ITEMS_KEY) as? [String] ?? []
            items.append(id)
            UserDefaults.standard.setValue(items, forKey: DELETED_ITEMS_KEY)
        }
    }
}
