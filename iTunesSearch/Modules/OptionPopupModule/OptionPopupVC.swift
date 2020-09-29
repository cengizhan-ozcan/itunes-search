//
//  OptionPopupVC.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class OptionPopupVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var popupViewCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var optionTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var backgroundButton: UIButton!
    
    // MARK: Properties
    var presenter: VPOptionPopupProtocol?
    var isFirstDidLayoutSubview = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        self.titleLabel.text = presenter?.getTitle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirstDidLayoutSubview {
            configureUI()
            animatePopupView(isOpen: true, completion: nil)
            isFirstDidLayoutSubview = false
        }
    }
    
    private func configureUI() {
        configureButtons()
        configureTableView()
    }
    
    private func configureButtons() {
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 2
        cancelButton.layer.borderColor = #colorLiteral(red: 0, green: 0.7176470588, blue: 0.7921568627, alpha: 1)
        cancelButton.layer.borderWidth = 2
        selectButton.layer.cornerRadius = selectButton.frame.height / 2
    }
    
    private func configureTableView() {
        let count = presenter?.getOptions().count ?? 0
        let maxCellCount = 5
        let tableViewHeight: CGFloat = 44 * CGFloat(count)
        if  maxCellCount >= count {
            optionTableViewHeightConstraint.constant = tableViewHeight
            self.view.layoutIfNeeded()
        }
        optionTableView.isScrollEnabled = maxCellCount < count
    }
    
    private func registerCell() {
        optionTableView.register(UINib(nibName: "OptionTVC", bundle: nil), forCellReuseIdentifier: OptionTVC.cellIdentifier)
    }
    
    @IBAction func backgroundButtonTapped(_ sender: Any) {
        animatePopupView(isOpen: false) { [weak self] in
            self?.presenter?.dismiss()
        }
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        animatePopupView(isOpen: false) { [weak self] in
            self?.presenter?.dismiss()
        }
    }
    
    @IBAction func selectButtonTapped(_ sender: Any) {
        animatePopupView(isOpen: false) { [weak self] in
            self?.presenter?.onSelection()
        }   
    }
    
    private func animatePopupView(isOpen: Bool, completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            let constant = isOpen ? 0 : self.view.frame.height
            let alpha: CGFloat = isOpen ? 0.4 : 0
            self.popupViewCenterYConstraint.constant = constant
            self.backgroundButton.alpha = alpha
            self.view.layoutIfNeeded()
        }) { (_) in
            completion?()
        }
    }
}

extension OptionPopupVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let options = presenter?.getOptions() ?? []
        presenter?.onSelectOption(for: options[indexPath.row])
        tableView.reloadData()
    }
}

extension OptionPopupVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getOptions().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionTVC.cellIdentifier, for: indexPath) as? OptionTVC else {
            return UITableViewCell()
        }
        let options = presenter?.getOptions() ?? []
        let selectedOption = presenter?.getSelectedOption() ?? ""
        let option = options[indexPath.row]
        let isSelected = options[indexPath.row] == selectedOption
        cell.configure(option: option, isSelected: isSelected)
        return cell
    }
}

extension OptionPopupVC: PVOptionPopupProtocol {
    
}
