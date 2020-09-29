//
//  SearchContractor.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

// MARK: View Input (View -> Presenter)
protocol VPSearchProtocol {
    var view: PVSearchProtocol? { get set }
    var interactor: PISearchProtocol? { get set }
    var router: PRSearchProtocol? { get set }
    
    func onSearch(with text: String)
    func showItemDetail(at index: Int)
    
    func showOptionPopup()
    func getSearchResultVMs() -> [SearchItemVM]
    func getTitle() -> String
    
}

// MARK: View Output (Presenter -> View)
protocol PVSearchProtocol: class {
    func setInfoView(with text: String, for visibility: Bool)
    func refreshData()
    func setLoading(isVisible: Bool)
    func deleteItem(for index: Int)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PISearchProtocol: class {
    var presenter: IPSearchProtocol? { get set }
    
    func search(for term: String, with media: MediaType, limit: Int)
    func invalidateSearch()
    func addSearchItemToSelectedList(with item: SearchResult)
    func isSearchItemSeen(for item: SearchResult) -> Bool
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol IPSearchProtocol: class {
    func onSearchSuccess(response: ITunes.Response.Search)
    func onSearchFailure(error: APIError)
}

// MARK: Router Input (Presenter -> Router)
protocol PRSearchProtocol {
    static func createModule() -> UIViewController
    func showOptionPopupModule(view: PVSearchProtocol, title: String, options: [String],
                               selectedOption: String, delegate: OptionPopupModuleDelegate)
    func showItemDetailModule(view: PVSearchProtocol, item: SearchResult, delegate: ItemDetailModuleDelegate)
    func showErrorAlert(view: PVSearchProtocol, with message: String)
}
