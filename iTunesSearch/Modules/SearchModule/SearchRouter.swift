//
//  SearchRouter.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class SearchRouter: PRSearchProtocol {
    
    static func createModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Search", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        
        var presenter: VPSearchProtocol & IPSearchProtocol = SearchPresenter()
        let interactor: PISearchProtocol = SearchInteractor()
        let router: PRSearchProtocol = SearchRouter()
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return vc
    }
    
    func showOptionPopupModule(view: PVSearchProtocol, title: String, options: [String],
                               selectedOption: String, delegate: OptionPopupModuleDelegate) {
        if let target = view as? UIViewController {
            let vc = OptionPopupRouter.createModule(title: title, optionList: options, selectedOption: selectedOption, delegate: delegate)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            target.present(vc, animated: true, completion: nil)
        }
    }
    
    func showItemDetailModule(view: PVSearchProtocol, item: SearchResult, delegate: ItemDetailModuleDelegate) {
        if let target = view as? UIViewController, let navigationController = target.navigationController {
            let vc = ItemDetailRouter.createModule(item: item, delegate: delegate)
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func showErrorAlert(view: PVSearchProtocol, with message: String) {
        if let view = view as? UIViewController {
            let alert = UIAlertController(title: "Error Occured", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            view.present(alert, animated: true)
        }
    }
}
