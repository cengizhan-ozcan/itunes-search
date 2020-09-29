//
//  ItemDetailVC.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/23/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class ItemDetailVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var itemDetailTableView: UITableView!
    @IBOutlet weak var itemDetailHeaderView: ItemDetailHeaderView!
    
    // MARK: Properties
    var presenter: VPItemDetailProtocol?
    var lastContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationController()
    }
    
    private func configureUI() {
        configureHeaderView()
        configureTableView()
    }
    
    private func configureNavigationController() {
        self.title = presenter?.getTitle() ?? ""
    }
    
    private func configureHeaderView() {
        let imageUrl = presenter?.getItemImage()
        itemDetailHeaderView.configure(imageUrl: imageUrl)
    }
    
    private func configureTableView() {
        itemDetailTableView.rowHeight = UITableView.automaticDimension
        itemDetailTableView.estimatedRowHeight = 44
    }
    
    private func registerCell() {
        itemDetailTableView.register(UINib(nibName: "ItemDetailTVC", bundle: nil), forCellReuseIdentifier: ItemDetailTVC.cellIdentifier)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        presenter?.deleteItem()
    }
}

extension ItemDetailVC: UITableViewDelegate {
    
}

extension ItemDetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getSearchItemVMList().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemDetailTVC.cellIdentifier, for: indexPath) as? ItemDetailTVC else {
            return UITableViewCell()
        }
        if let searchItemVMList = presenter?.getSearchItemVMList() {
            let searchItemVM = searchItemVMList[indexPath.row]
            cell.configure(item: searchItemVM)
        }
        return cell
    }
    
}

extension ItemDetailVC: PVItemDetailProtocol {
    
}
