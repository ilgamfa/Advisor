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
    private var collectionViewCellImages = [UIImage]()
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var rate = ""
    var selfIndexPath = 0
    var collectionItemName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch selfIndexPath{
        case 0:
            rate = "1h"
            collectionItemName = "interesting_places"
            collectionViewCellNames = ["Architecture", "Cultural", "Historical", "Industrial facilities", "Natural", "Other", "Religion"]
            collectionViewCellImages = [UIImage(named: "architecture")!, UIImage(named: "culture")!, UIImage(named: "historical")!, UIImage(named: "industrial")!, UIImage(named: "nature")!, UIImage(named: "other")!, UIImage(named: "religion")!]
        case 1:
            rate = "2"
            collectionItemName = "tourist_facilities"
            collectionViewCellNames = ["Banks", "Foods", "Shops", "Transport"]
            collectionViewCellImages = [UIImage(named: "banks")!, UIImage(named: "foods")!, UIImage(named: "shops")!, UIImage(named: "transport")!]
        case 2:
            rate = "1"
            collectionItemName = "amusements"
            collectionViewCellNames = ["Parks", "Ferris wheels", "Mini parks", "Roller coaster", "Water parks"]
            collectionViewCellImages = [UIImage(named: "parks")!, UIImage(named: "ferrisWheel")!, UIImage(named: "miniPark")!, UIImage(named: "rollerCoaster")!, UIImage(named: "waterPark")!]
        case 3:
            rate = "3"
            collectionItemName = "accomodations"
            collectionViewCellNames = ["Apartments", "Hotels", "Hostels", "Resorts", "Villas and chalet"]
            collectionViewCellImages = [UIImage(named: "apartment")!, UIImage(named: "hotel")!, UIImage(named: "hostel")!, UIImage(named: "resort")!, UIImage(named: "villas")!]
        case 4:
            rate = "3"
            collectionItemName = "sport"
            collectionViewCellNames = ["Pools", "Stadiums", "Winter sport", "Climbind", "Diving", "Kitesurfing", "Surfing"]
            
            collectionViewCellImages = [UIImage(named: "pools")!, UIImage(named: "stadium")!, UIImage(named: "winterSports")!, UIImage(named: "climbing")!, UIImage(named: "diving")!, UIImage(named: "kitesurfing")!, UIImage(named: "surf")!]
        case 5:
            rate = "3"
            collectionItemName = "adult"
            collectionViewCellNames = ["Alcohol", "Casino", "Hookah", "Night clubs"]
            collectionViewCellImages = [UIImage(named: "alcohol")!, UIImage(named: "casino")!, UIImage(named: "hookah")!, UIImage(named: "nightClub")!]
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
        viewModel.fetchData(rate: rate, kinds: collectionItemName) { [weak self] in
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
        
        detailVC.xid = attraction.xid
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FeedItemsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowInSection = viewModel.numbersOfRowsInSection(section: section)
        if numberOfRowInSection == 0 {
//            showAllert()
        }
        return numberOfRowInSection
    }
    
    private func showAllert() {
        let message = "There are no places in the selected category within a radius of 100 km from you"
        
        let alert = UIAlertController(title: "Sorry!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
       
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
        cell.collectionCellImage.image = collectionViewCellImages[indexPath.row]
        return cell
    }
    
    
    
    
}
