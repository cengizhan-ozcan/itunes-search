//
//  SearchInteractor.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

class SearchInteractor {
    
    var presenter: IPSearchProtocol?
    
    let manager = ITunesManager()
    
    func filterSearchResultsIfNeeded(searchResults: [SearchResult]) -> [SearchResult] {
        let deletedItemIdList = SearchDataSource.shared.deletedItemIdList
        if (deletedItemIdList.count > 0) {
            return searchResults.filter({ result in
                guard let trackId = result.trackId, let trackName = result.trackName else {
                    return false
                }
                let id = "\(trackId)-\(trackName)-\(result.artistName)"
                return !deletedItemIdList.contains(id)
            })
        }
        return searchResults
    }
    
    func getNormalizedTerm(for term: String) -> String {
        let trimmedTerm = term.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        let encodedTerm = trimmedTerm.replacingOccurrences(of: " ", with: "+")
        let normalizedTerm = encodedTerm.folding(options: .diacriticInsensitive, locale: Locale(identifier: "en_US"))
        return normalizedTerm
    }
    
}

extension SearchInteractor: PISearchProtocol {
    
    func search(for term: String, with media: MediaType, limit: Int) {
        let normalizedTerm = getNormalizedTerm(for: term)
        manager.search(term: normalizedTerm, media: media, limit: limit) { [weak self] (result) in
            switch result {
            case .success(let resp):
                var response = resp
                response.results = self?.filterSearchResultsIfNeeded(searchResults: resp.results ?? []) ?? resp.results
                self?.presenter?.onSearchSuccess(response: response)
            case .failure(let error):
                self?.presenter?.onSearchFailure(error: error)
            }
        }
    }
    
    func invalidateSearch() {
        manager.invalidateSearch()
    }
    
    func addSearchItemToSelectedList(with item: SearchResult) {
        guard let trackId = item.trackId, let trackName = item.trackName else {
                   return
        }
        SearchDataSource.shared.addNewSeenItem(for: "\(trackId)-\(trackName)-\(item.artistName)")
    }
    
    func isSearchItemSeen(for item: SearchResult) -> Bool {
        guard let trackId = item.trackId, let trackName = item.trackName else {
            return false
        }
        return SearchDataSource.shared.seenItemIdList.contains("\(trackId)-\(trackName)-\(item.artistName)")
    }
    
}
