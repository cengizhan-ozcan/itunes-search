//
//  QuestionPopupContractor.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

// MARK: Segue Data
protocol QuestionPopupSegueDataProtocol {
    var questionText: String! { get set }
}

// MARK: View Input (View -> Presenter)
protocol VPQuestionPopupProtocol {
    var view: PVQuestionPopupProtocol? { get set }
    var interactor: PIQuestionPopupProtocol? { get set }
    var router: PRQuestionPopupProtocol? { get set }
    var delegate: QuestionPopupModuleDelegate? { get set }
    
    func onAnswer(_ isConfirmed: Bool)
    func dismiss()
    func getQuestion() -> String
    
}

// MARK: View Output (Presenter -> View)
protocol PVQuestionPopupProtocol: class {
    
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PIQuestionPopupProtocol: class {
    var presenter: IPQuestionPopupProtocol? { get set }
    
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol IPQuestionPopupProtocol: class {
    
}

// MARK: Router Input (Presenter -> Router)
protocol PRQuestionPopupProtocol {
    static func createModule(questionText: String, delegate: QuestionPopupModuleDelegate?) -> UIViewController
    func dismiss(view: PVQuestionPopupProtocol)
}

protocol QuestionPopupModuleDelegate {
    func onAnswer(isConfirmed: Bool)
}
