//
//  CollectionItemViewController.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 07.10.2021.
//

import UIKit

class TableItemVC: UIViewController {

    // MARK: Private
    private var viewModel = AttractionViewModel()
    
    private var reuseIdCell = "tableViewCell"
    private let goToControllerId = "detailVC"
    
    private let collectionViewCellNames = ["Architecture", "Cultural", "Historical", "Industrial facilities", "Natural", "Other", "Religion"]
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
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
        
        loadItemsData()
        
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
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


extension TableItemVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let detailVC = storyboard?.instantiateViewController(identifier: goToControllerId) as? DetailViewController else {
            return
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension TableItemVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Great Spots Near You"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdCell, for: indexPath) as! ItemTVCell
        
        let attraction = viewModel.cellForRowAt(indexPath: indexPath)
        
        cell.setCellWithValuesOf(attraction)
        
        return cell
    }
    
    
}





//extension TableItemVC: UICollectionViewDelegate {
//
//}
//
//extension TableItemVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return UICollectionViewCell()
//    }
//
//
//}