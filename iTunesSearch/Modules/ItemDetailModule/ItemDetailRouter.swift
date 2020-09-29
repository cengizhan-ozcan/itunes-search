//
//  ItemDetailRouter.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/23/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class ItemDetailRouter: PRItemDetailProtocol {
    
    static func createModule(item: SearchResult, delegate: ItemDetailModuleDelegate?) -> UIViewController {
        let storyboard = UIStoryboard(name: "ItemDetail", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ItemDetailVC") as! ItemDetailVC
        
        var presenter: VPItemDetailProtocol & IPItemDetailProtocol & ItemDetailSegueDataProtocol = ItemDetailPresenter()
        let interactor: PIItemDetailProtocol = ItemDetailInteractor()
        let router: PRItemDetailProtocol = ItemDetailRouter()
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        presenter.delegate = delegate
        presenter.searchResult = item
        
        return vc
    }
    
      func showQuestionPopupModule(view: PVItemDetailProtocol, questionText: String, delegate: QuestionPopupModuleDelegate) {
          if let target = view as? UIViewController {
              let vc = QuestionPopupRouter.createModule(questionText: questionText, delegate: delegate)
              vc.modalPresentationStyle = .overFullScreen
              vc.modalTransitionStyle = .crossDissolve
              target.present(vc, animated: false, completion: nil)
          }
      }
    
    func dismiss(view: PVItemDetailProtocol) {
        if let view = view as? UIViewController {
            view.navigationController?.popViewController(animated: true)
        }
    }
    
}
