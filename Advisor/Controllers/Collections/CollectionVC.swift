//
//  HomeViewController.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.09.2021.
//

import UIKit


class CollectionViewController: UIViewController {
    
    // MARK: private
    private var collections = ["Interesting places", "Tourist facilities", "Amusements", "Accommodations", "Sport", "Adult"]
    
    private let reuseIdCell = "collectionCell"
    
    private let goToControllerId = "collectionItem"
    

    
    // MARK: Outlet
    @IBOutlet private weak var tableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
   

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
        guard let collectionItemVC = storyboard?.instantiateViewController(identifier: goToControllerId) as? ItemOfCollectionVC else {
            return
        }
        collectionItemVC.selfIndexPath = indexPath.row
        
        collectionItemVC.title = collections[indexPath.row]
        
        navigationController?.pushViewController(collectionItemVC, animated: true)
        
    }
}
