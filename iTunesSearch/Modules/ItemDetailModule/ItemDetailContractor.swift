//
//  ItemDetailContractor.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/23/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

// MARK: Segue Data
protocol ItemDetailSegueDataProtocol {
    var searchResult: SearchResult! { get set }
}

// MARK: View Input (View -> Presenter)
protocol VPItemDetailProtocol {
    var view: PVItemDetailProtocol? { get set }
    var interactor: PIItemDetailProtocol? { get set }
    var router: PRItemDetailProtocol? { get set }
    var delegate: ItemDetailModuleDelegate? { get set }
    
    func getTitle() -> String
    func getSearchItemVMList() -> [SearchItemDetailVM]
    func getItemImage() -> String?
    func deleteItem()
    
}

// MARK: View Output (Presenter -> View)
protocol PVItemDetailProtocol: class {
    
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PIItemDetailProtocol: class {
    var presenter: IPItemDetailProtocol? { get set }
    
    func addSeachItemToDeletedList(with item: SearchResult)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol IPItemDetailProtocol: class {
    
}

// MARK: Router Input (Presenter -> Router)
protocol PRItemDetailProtocol {
    static func createModule(item: SearchResult, delegate: ItemDetailModuleDelegate?) -> UIViewController
    func showQuestionPopupModule(view: PVItemDetailProtocol, questionText: String, delegate: QuestionPopupModuleDelegate)
    func dismiss(view: PVItemDetailProtocol)
}

protocol ItemDetailModuleDelegate {
    func onItemDelete(for item: SearchResult)
}
