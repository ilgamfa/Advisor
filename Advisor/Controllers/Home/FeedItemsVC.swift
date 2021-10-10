//
//  CollectionItemViewController.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 07.10.2021.
//

import UIKit

class FeedItemsVC: UIViewController {

    // MARK: Private
    private var viewModel = AttractionViewModel()
    
    private var reuseTableIdCell = "tableViewCell"
    private var reuseCollectionIdCell = "collectionViewCell"
    private let goToDetailController = "detailVC"
    private let goToCollectionDetailController = "ItemCVController"
    
    private var collectionViewCellNames = [String]()
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var selfIndexPath = 0
    var collectionItemName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch selfIndexPath{
        case 0:
            collectionItemName = "interesting_places"
            collectionViewCellNames = ["Architecture", "Cultural", "Historical", "Industrial facilities", "Natural", "Other", "Religion"]
        case 1:
            collectionItemName = "tourist_facilities"
            collectionViewCellNames = ["Banks", "Foods", "Shops", "Transport"]
        case 2:
            collectionItemName = "amusements"
            collectionViewCellNames = ["Parks", "Ferris wheels", "Mini parks", "Roller coaster", "Water parks"]
        case 3:
            collectionItemName = "accomodations"
            collectionViewCellNames = ["Apartments", "Hotels", "Hostels", "Resorts", "Villas and chalet"]
        case 4:
            collectionItemName = "sport"
            collectionViewCellNames = ["Pools", "Stadiums", "Winter sport", "Climbind", "Diving", "Kitesurfing", "Surfing"]
        case 5:
            collectionItemName = "adult"
            collectionViewCellNames = ["Alcohol", "Casino", "Hookah", "Night clubs"]
        default:
            collectionItemName = ""
        }
        
        loadItemsData()
        
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
 
    
    private func loadItemsData() {
        viewModel.fetchData(kinds: collectionItemName) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}


extension FeedItemsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let detailVC = storyboard?.instantiateViewController(identifier: goToDetailController) as? DetailViewController else {
            return
        }
        let attraction = viewModel.cellForRowAt(indexPath: indexPath)
        guard let name = attraction.name else { return }
        
        detailVC.xid = attraction.xid
        detailVC.name = name
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FeedItemsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseTableIdCell, for: indexPath) as! FeedItemTVCell
        
        let attraction = viewModel.cellForRowAt(indexPath: indexPath)
        
        cell.setCellWithValuesOf(attraction)
        
        return cell
    }
    
    
}


extension FeedItemsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let itemCVController = storyboard?.instantiateViewController(identifier: goToCollectionDetailController) as? ItemCVController else {
            return
        }
        
        itemCVController.title = collectionViewCellNames[indexPath.row]
        navigationController?.pushViewController(itemCVController, animated: true)
        
    }
    
}


extension FeedItemsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCollectionIdCell, for: indexPath) as! FeedItemCVCell
        cell.collectionCellLabel.text = collectionViewCellNames[indexPath.row]
        return cell
    }
    
    
    
    
}
