//
//  HomeViewController.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.09.2021.
//

import UIKit


class CollectionViewController: UIViewController {
    
    // MARK: private
    private var collections = ["Interesting places","Accommodations", "Adult", "Amusements", "Sport", "Tourist facilities"]
    
    private let reuseIdCell = "collectionCell"
    
    private let goToControllerId = "collectionItem"
    
//    private var viewModel = AttractionViewModel()
    
    // MARK: Outlet
    @IBOutlet private weak var tableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
//        loadAttractionsData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
//    private func loadAttractionsData() {
//        viewModel.fetchData { [weak self] in
//            DispatchQueue.main.async {
//                self?.homeTableView.reloadData()
//            }
//
//        }
//    }
    
    
    

}

// MARK: Data source
extension CollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdCell, for: indexPath) as! CollectionTableViewCell
        cell.collectionLabel.text = collections[indexPath.row]
        return cell
        
    
    }
}

extension CollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let collectionItemVC = storyboard?.instantiateViewController(identifier: goToControllerId) as? CollectionItemViewController else {
            return
        }
        collectionItemVC.title = collections[indexPath.row]
        
        navigationController?.pushViewController(collectionItemVC, animated: true)
        
    }
}
