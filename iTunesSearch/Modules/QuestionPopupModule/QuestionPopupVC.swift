//
//  QuestionPopupVC.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class QuestionPopupVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    // MARK: - Properties
    var presenter: VPQuestionPopupProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setInitialData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        animatePopupView(isOpen: true, completion: nil)
    }
    
    private func configureUI() {
        noButton.layer.cornerRadius = noButton.frame.height / 2
        noButton.layer.borderColor = #colorLiteral(red: 0, green: 0.7176470588, blue: 0.7921568627, alpha: 1)
        noButton.layer.borderWidth = 2
        yesButton.layer.cornerRadius = yesButton.frame.height / 2
    }
    
    private func setInitialData() {
        questionLabel.text = presenter?.getQuestion()
    }
    
    @IBAction func backgroundButtonTapped(_ sender: Any) {
        animatePopupView(isOpen: false) { [weak self] in
            self?.presenter?.dismiss()
        }
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        animatePopupView(isOpen: false) { [weak self] in
            self?.presenter?.onAnswer(false)
        }
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        animatePopupView(isOpen: false) { [weak self] in
            self?.presenter?.onAnswer(true)
        }
    }
    
    private func animatePopupView(isOpen: Bool, completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self = self else { return }
            let constant = isOpen ? 0 : -self.popupView.frame.height
            let alpha: CGFloat = isOpen ? 0.4 : 0
            self.popupViewBottomConstraint.constant = constant
            self.backgroundButton.alpha = alpha
            self.view.layoutIfNeeded()
        }) { (_) in
            completion?()
        }
    }
    
}

extension QuestionPopupVC: PVQuestionPopupProtocol {
    
}
