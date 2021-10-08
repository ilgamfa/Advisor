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
extension HomeTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdCell, for: indexPath) as! HomeTVCell
        cell.collectionLabel.text = collectionNames[indexPath.row]
        cell.collectionImage.image = collectionImages[indexPath.row]
        return cell
        
    
    }
}

extension HomeTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let tableItemVC = storyboard?.instantiateViewController(identifier: goToControllerId) as? FeedItemsVC else {
            return
        }
        tableItemVC.selfIndexPath = indexPath.row
        
        tableItemVC.title = collectionNames[indexPath.row]
        
        navigationController?.pushViewController(tableItemVC, animated: true)
        
    }
}
