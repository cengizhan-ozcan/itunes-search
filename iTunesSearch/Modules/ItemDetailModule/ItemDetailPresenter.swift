//
//  ItemDetailPresenter.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/23/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class ItemDetailPresenter: VPItemDetailProtocol {
    
    weak var view: PVItemDetailProtocol?
    var interactor: PIItemDetailProtocol?
    var router: PRItemDetailProtocol?
    var delegate: ItemDetailModuleDelegate?
    
    var searchResult: SearchResult!
    
    func deleteItem() {
        router?.showQuestionPopupModule(view: view!, questionText: "Do you want to delete this item?", delegate: self)
    }
    
    func getTitle() -> String {
        let trackName = searchResult.trackCensoredName ?? searchResult.trackName ?? "Unknown"
        let artistName = searchResult.artistName
        if let kind = searchResult.kind {
            switch kind {
            case .album, .artistFor, .book, .coachedAudio, .interactiveBooklet, .musicVideo, .song:
                return "\(trackName) - \(artistName)"
            default:
                return "\(trackName)"
            }
        }
        return "Unkown"
    }
    
    func getSearchItemVMList() -> [SearchItemDetailVM] {
        let vmList: [SearchItemDetailVM] = [
            SearchItemDetailVM(searchResult: searchResult, titleType: .trackName),
            SearchItemDetailVM(searchResult: searchResult, titleType: .artistName),
            SearchItemDetailVM(searchResult: searchResult, titleType: .collectionName),
            SearchItemDetailVM(searchResult: searchResult, titleType: .kind)
        ]
        return vmList
    }
    
    func getItemImage() -> String? {
        return searchResult.artworkUrl100
    }
    
}

extension ItemDetailPresenter: IPItemDetailProtocol {
    
}

extension ItemDetailPresenter: ItemDetailSegueDataProtocol {
    
}

extension ItemDetailPresenter: QuestionPopupModuleDelegate {
    
    func onAnswer(isConfirmed: Bool) {
        if isConfirmed {
            interactor?.addSeachItemToDeletedList(with: searchResult)
            delegate?.onItemDelete(for: searchResult)
            router?.dismiss(view: view!)
        }
    }
    
}
