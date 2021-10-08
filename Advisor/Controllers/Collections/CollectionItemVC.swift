//
//  CollectionItemViewController.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 07.10.2021.
//

import UIKit

class ItemOfCollectionVC: UIViewController {

    // MARK: Privat
    private var viewModel = AttractionViewModel()
    private var reuseIdCell = "collectionItemCell"
    private let goToControllerId = "detailVC"
    
    @IBOutlet private weak var tableView: UITableView!
    
    var selfIndexPath = 0
    var collectionItemName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch selfIndexPath{
        case 0:
            collectionItemName = "interesting_places"
        case 1:
            collectionItemName = "tourist_facilities"
        case 2:
            collectionItemName = "amusements"
        case 3:
            collectionItemName = "accomodations"
        case 4:
            collectionItemName = "sport"
        case 5:
            collectionItemName = "adult"
        default:
            collectionItemName = ""
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
 
    
    private func loadItemsData() {
        viewModel.fetchData(kinds: collectionItemName) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}


extension ItemOfCollectionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let detailVC = storyboard?.instantiateViewController(identifier: goToControllerId) as? DetailViewController else {
            return
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ItemOfCollectionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdCell, for: indexPath) as! CollectionItemTVCell
        cell.collectionItemLabel.text = "place name"
        return cell
    }
    
    
}





extension ItemOfCollectionVC: UICollectionViewDelegate {
    
}

extension ItemOfCollectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
