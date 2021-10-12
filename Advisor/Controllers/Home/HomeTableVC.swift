//
//  HomeViewController.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.09.2021.
//

import UIKit


class HomeTableViewController: UIViewController {
    
    // MARK: private
    private var collectionNames = ["Interesting places", "Tourist facilities", "Amusements", "Accommodations", "Sport", "Adult"]
    
    private var collectionImages = [UIImage(named: "interestingPlaces"), UIImage(named: "touristFacilities"), UIImage(named: "amusements"), UIImage(named: "accommodations"), UIImage(named: "sport"), UIImage(named: "adult")]
    
    private let reuseIdCell = "collectionCell"
    private let goToControllerId = "TableItemVC"
    

    
    // MARK: Outlet
    @IBOutlet private weak var tableView: UITableView!

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
//        tableView.dataSource = self
//        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
   

}

extension HomeTableViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let feedItemsVC = storyboard?.instantiateViewController(identifier: goToControllerId) as? FeedItemsVC else {
            return
        }
        feedItemsVC.selfIndexPath = indexPath.row

        feedItemsVC.title = collectionNames[indexPath.row]

        navigationController?.pushViewController(feedItemsVC, animated: true)
        
    }
}

extension HomeTableViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdCell, for: indexPath) as! HomeCVCell
        cell.collectionLabel.text = collectionNames[indexPath.row]
        cell.collectionImage.image = collectionImages[indexPath.row]
        return cell
    }
    
    
}






//// MARK: Data source
//extension HomeTableViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return collectionNames.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdCell, for: indexPath) as! HomeTVCell
//        cell.collectionLabel.text = collectionNames[indexPath.row]
//        cell.collectionImage.image = collectionImages[indexPath.row]
//        return cell
//
//
//    }
//}
////
//extension HomeTableViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        guard let feedItemsVC = storyboard?.instantiateViewController(identifier: goToControllerId) as? FeedItemsVC else {
//            return
//        }
//        feedItemsVC.selfIndexPath = indexPath.row
//
//        feedItemsVC.title = collectionNames[indexPath.row]
//
//        navigationController?.pushViewController(feedItemsVC, animated: true)
//
//    }
//}
