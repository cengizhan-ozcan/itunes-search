//
//  SearchVC.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    // MARK: Properties
    var presenter: VPSearchProtocol?
    let throttler = Throttler(minimumDelay: 0.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        registerCell()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.searchCollectionView.collectionViewLayout.invalidateLayout()
    }

    private func configureUI() {
        self.navigationController?.title = presenter?.getTitle() ?? ""
        searchCollectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        searchCollectionView.keyboardDismissMode = .onDrag
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        infoView.addGestureRecognizer(tapGesture)
    }
    
    private func registerCell() {
        searchCollectionView.register(UINib(nibName: "SearchCVC", bundle: nil), forCellWithReuseIdentifier: SearchCVC.cellIdentifier)
    }
    
    @objc func backgroundTapped() {
        self.view.endEditing(true)
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        presenter?.showOptionPopup()
    }
}

extension SearchVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showItemDetail(at: indexPath.row)
    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: (collectionView.frame.width - 24) / 2, height: 150)
        }
        if UIDevice.current.orientation.isPortrait {
            return CGSize(width: collectionView.frame.width - 16, height: 80)
        }
        return CGSize(width: (collectionView.frame.width - 24) / 2, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension SearchVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getSearchResultVMs().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCVC.cellIdentifier, for: indexPath) as? SearchCVC else {
            return UICollectionViewCell()
        }
        if let searchResultVMs = presenter?.getSearchResultVMs() {
            let item = searchResultVMs[indexPath.row]
            cell.configure(with: item)
        }
        return cell
    }
}

extension SearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        throttler.throttle { [weak self] in
            guard let text = searchBar.text else { return }
            self?.presenter?.onSearch(with: text)
        }
    }
    
}

extension SearchVC: PVSearchProtocol {
    
    func setInfoView(with text: String, for visibility: Bool) {
        self.infoView.isHidden = !visibility
        self.infoLabel.text = text
    }
    
    func refreshData() {
        searchCollectionView.reloadData()
    }
    
    func setLoading(isVisible: Bool) {
        if isVisible {
            loadingIndicatorView.startAnimating()
        } else {
            loadingIndicatorView.stopAnimating()
        }
    }
    
    func deleteItem(for index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.searchCollectionView.performBatchUpdates({ [weak self] in
            self?.searchCollectionView.deleteItems(at:[indexPath])
        }, completion:nil)
    }
}
