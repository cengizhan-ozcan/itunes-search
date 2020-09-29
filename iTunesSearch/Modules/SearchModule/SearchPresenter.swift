//
//  SearchPresenter.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class SearchPresenter: VPSearchProtocol {
    
    weak var view: PVSearchProtocol?
    var interactor: PISearchProtocol?
    var router: PRSearchProtocol?
    
    var lastSearchText: String?
    var searchResults: [SearchResult] = []
    var searchResultVMList: [SearchItemVM] = []
    var selectedMedia: MediaType = .all
    
    func onSearch(with text: String) {
        self.lastSearchText = text
        if text != "" {
            view?.setLoading(isVisible: true)
            view?.setInfoView(with: "", for: false)
            interactor?.search(for: text, with: selectedMedia, limit: 100)
        } else {
            setEmptyScreen()
            interactor?.invalidateSearch()
        }
    }
    
    func getSearchResultVMs() -> [SearchItemVM] {
        return self.searchResultVMList
    }
    
    func getTitle() -> String {
        return "ITunes Search"
    }
    
    func showOptionPopup() {
        let options = MediaType.allCases.map { $0.rawValue }
        router?.showOptionPopupModule(view: view!, title: "Select Media Type", options: options, selectedOption: selectedMedia.rawValue, delegate: self)
    }
    
    func showItemDetail(at index: Int) {
        let searchResult = searchResults[index]
        interactor?.addSearchItemToSelectedList(with: searchResult)
        self.searchResultVMList[index] = SearchItemVM(searchResult: searchResult, isSeen: true)
        router?.showItemDetailModule(view: view!, item: searchResult, delegate: self)
        view?.refreshData()
    }
    
    func setEmptyScreen() {
        searchResults = []
        searchResultVMList = []
        view?.refreshData()
        view?.setInfoView(with: "Search On ITunes!", for: true)
    }
}

extension SearchPresenter: IPSearchProtocol {
    
    func onSearchSuccess(response: ITunes.Response.Search) {
        self.searchResults = response.results ?? []
        self.searchResultVMList = searchResults.map {
            SearchItemVM(searchResult: $0, isSeen: interactor?.isSearchItemSeen(for: $0) ?? false)
        }
        view?.setLoading(isVisible: false)
        if searchResults.count == 0 {
            view?.setInfoView(with: "No Result", for: true)
        } else {
            if lastSearchText == "" {
                setEmptyScreen()
            } else {
                view?.setInfoView(with: "", for: false)
            }
        }
        view?.refreshData()
    }
    
    func onSearchFailure(error: APIError) {
        view?.setLoading(isVisible: false)
        view?.setInfoView(with: "Error Occured", for: true)
        let message = error.errorDescription ?? "Unexpected error occured."
        router?.showErrorAlert(view: view!, with: message)
    }    
}



extension SearchPresenter: OptionPopupModuleDelegate {
    
    func onSelected(option: String) {
        guard let media = MediaType(rawValue: option) else { return }
        if self.selectedMedia != media {
            self.selectedMedia = media
            guard let text = lastSearchText else { return }
            onSearch(with: text)
        }
    }
}

extension SearchPresenter: ItemDetailModuleDelegate {
    
    func onItemDelete(for item: SearchResult) {
        let tempVM = SearchItemVM(searchResult: item, isSeen: false)
        guard let index = searchResultVMList.firstIndex(where: { return $0.title == tempVM.title}) else {
            return
        }
        self.searchResultVMList.remove(at: index)
        self.searchResults.remove(at: index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.view?.deleteItem(for: index)
            self?.view?.refreshData()
        }
    }
}

