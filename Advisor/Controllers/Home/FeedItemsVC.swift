//
//  CollectionItemViewController.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 07.10.2021.
//

import UIKit
import MapKit

class FeedItemsVC: UIViewController {

    // MARK: Private
    private var viewModel = AttractionViewModel()
    
    private var reuseTableIdCell = "tableViewCell"
    private var reuseCollectionIdCell = "collectionViewCell"
    private let goToDetailController = "detailVC"
    private let goToCollectionDetailController = "ItemCVController"
    
    private var collectionViewCellNames = [String]()
    private var collectionViewCellImages = [UIImage]()
    private var collectionViewCellRequestSubcatNames = [String]()
    private var collectionViewCellRequestSubcatRates = [String]()
    
    // MARK: Outlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var headerTableView: UILabel!
    
    @IBOutlet private weak var spinnerIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var spinnerView: UIView!
    
    // MARK: Public
    var rate = ""
    var selfIndexPath = 0
    var collectionItemName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinnerView.layer.masksToBounds = false
        spinnerView.layer.cornerRadius = 20
        
        // MARK: Switch
        switch selfIndexPath{
            // MARK: Case 0
        case 0:
            rate = "1h"
            collectionItemName = "interesting_places"
            
            collectionViewCellNames = [
                "Architecture",
                "Cultural",
                "Historical",
                "Industrial facilities",
                "Natural",
                "Other",
                "Religion"
            ]
            
            collectionViewCellImages = [
                UIImage(named: "architecture")!,
                UIImage(named: "culture")!,
                UIImage(named: "historical")!,
                UIImage(named: "industrial")!,
                UIImage(named: "nature")!,
                UIImage(named: "other")!,
                UIImage(named: "religion")!
            ]
            
            collectionViewCellRequestSubcatNames = [
                "architecture",
                "cultural",
                "historic",
                "industrial_facilities",
                "natural",
                "other",
                "religion"
            ]
            
            collectionViewCellRequestSubcatRates = [
                "1h",
                "3",
                "3",
                "1",
                "3",
                "1",
                "3",
            ]
            
            // MARK: Case 1
        case 1:
            rate = "2"
            collectionItemName = "tourist_facilities"
            collectionViewCellNames = [
                "Banks",
                "Foods",
                "Shops",
                "Transport"
            ]
            
            collectionViewCellImages = [
                UIImage(named: "banks")!,
                UIImage(named: "foods")!,
                UIImage(named: "shops")!,
                UIImage(named: "transport")!
            ]
            
            collectionViewCellRequestSubcatNames = [
                "banks",
                "foods",
                "shops",
                "transport"
            ]
            
            collectionViewCellRequestSubcatRates = [
                "1",
                "1",
                "1",
                "1"
            ]
            
            // MARK: Case 2
        case 2:
            rate = "1"
            collectionItemName = "amusements"
            collectionViewCellNames = [
                "Parks",
                "Ferris wheels",
                "Mini parks",
                "Roller coaster",
                "Water parks"
            ]
            
            collectionViewCellImages = [
                UIImage(named: "parks")!,
                UIImage(named: "ferrisWheel")!,
                UIImage(named: "miniPark")!,
                UIImage(named: "rollerCoaster")!,
                UIImage(named: "waterPark")!
            ]
        
            collectionViewCellRequestSubcatNames = [
                "amusement_parks",
                "ferris_wheels",
                "miniature_parks",
                "roller_coasters",
                "water_parks"
            ]
            
            collectionViewCellRequestSubcatRates = [
                "1",
                "0",
                "0",
                "0",
                "1"
            ]
            
            // MARK: Case 3
        case 3:
            rate = "3"
            collectionItemName = "accomodations"
            collectionViewCellNames = [
                "Apartments",
                "Hotels",
                "Hostels",
                "Resorts",
                "Villas and chalet"
            ]
            
            collectionViewCellImages = [
                UIImage(named: "apartment")!,
                UIImage(named: "hotel")!,
                UIImage(named: "hostel")!,
                UIImage(named: "resort")!,
                UIImage(named: "villas")!
            ]
            
            collectionViewCellRequestSubcatNames = [
                "apartments",
                "other_hotels",
                "hostels",
                "resorts",
                "villas_and_chalet"
            ]
            
            collectionViewCellRequestSubcatRates = [
                "1",
                "1",
                "1",
                "1",
                "1"
            ]
            
            // MARK: Case 4
        case 4:
            rate = "3"
            collectionItemName = "sport"
            collectionViewCellNames = [
                "Pools",
                "Stadiums",
                "Winter sport",
                "Climbind",
                "Diving",
                "Kitesurfing",
                "Surfing"
            ]
            
            collectionViewCellImages = [
                UIImage(named: "pools")!,
                UIImage(named: "stadium")!,
                UIImage(named: "winterSports")!,
                UIImage(named: "climbing")!,
                UIImage(named: "diving")!,
                UIImage(named: "kitesurfing")!,
                UIImage(named: "surf")!
            ]
            
            collectionViewCellRequestSubcatNames = [
                "pools",
                "stadiums",
                "winter_sports",
                "climbing",
                "diving",
                "kitesurfing",
                "surfing"
            ]
            
            collectionViewCellRequestSubcatRates = [
                "1",
                "1",
                "0",
                "1",
                "0",
                "0",
                "0",
            ]
            
            // MARK: Case 5
        case 5:
            rate = "3"
            collectionItemName = "adult"
            collectionViewCellNames = [
                "Alcohol",
                "Casino",
                "Hookah",
                "Night clubs"
            ]
            
            collectionViewCellImages = [
                UIImage(named: "alcohol")!,
                UIImage(named: "casino")!,
                UIImage(named: "hookah")!,
                UIImage(named: "nightClub")!
            ]
            
            collectionViewCellRequestSubcatNames = [
                "alcohol",
                "casino",
                "hookah",
                "nightclubs"
            ]
            
            collectionViewCellRequestSubcatRates = [
                "1",
                "3",
                "0",
                "1"
            ]
            
            // MARK: Case Default
        default:
            collectionItemName = ""
        }
        
        showSpinner()
        loadItemsData()
        
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        viewModel.delegate = self
    }

    
    // MARK: Private functions
    
    private func showSpinner() {
        DispatchQueue.main.async {
            self.spinnerIndicator.startAnimating()
            self.spinnerView.isHidden = false
        }
    }
    
    private func hideSpinner() {
        DispatchQueue.main.async {
            self.spinnerIndicator.stopAnimating()
            self.spinnerView.isHidden = true
        }
    }
    
    private func loadItemsData() {
        viewModel.fetchData(rate: rate, kinds: collectionItemName) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.hideSpinner()
            }
        }
    }
    
    private func loadSubcategoryItemsData(kinds: String, rate: String) {
        viewModel.fetchData(rate: rate, kinds: kinds) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.hideSpinner()
            }
        }
    }
}

// MARK: UITableView
extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

// MARK: UI TableView Delegate
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

// MARK: UI TableView DataSource
extension FeedItemsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowInSection = viewModel.numbersOfRowsInSection(section: section)
        
        if numberOfRowInSection == 0 {
            self.tableView.setEmptyMessage("No results were found")
        }
        else {
            self.tableView.restore()
        }
        
        return numberOfRowInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseTableIdCell, for: indexPath) as! FeedItemTVCell
        
        let attraction = viewModel.cellForRowAt(indexPath: indexPath)
        
        cell.setCellWithValuesOf(attraction)
        cell.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        
        cell.layer.cornerRadius = 10
        cell.contentView.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 1, height: 2)
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.75
        cell.layer.masksToBounds = false
        
        return cell
    }
    
    
}

// MARK: UI CollectionView Delegate
extension FeedItemsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        headerTableView.text = collectionViewCellNames[indexPath.row]
        let kinds = collectionViewCellRequestSubcatNames[indexPath.row]
        let rate = collectionViewCellRequestSubcatRates[indexPath.row]
        showSpinner()
        loadSubcategoryItemsData(kinds: kinds, rate: rate)
    }
    
}

// MARK: UI CollectionView DataSource
extension FeedItemsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCollectionIdCell, for: indexPath) as! FeedItemCVCell
        cell.collectionCellLabel.text = collectionViewCellNames[indexPath.row]
        cell.collectionCellImage.image = collectionViewCellImages[indexPath.row]
        
        cell.layer.cornerRadius = 10
        cell.contentView.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowRadius = 1
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        return cell
    }

}
extension FeedItemsVC: ShowAlertWhenError {
    
    func showAlertWhenError() {
        let alert = UIAlertController(title: "Data will not appear until you give access" , message: "Please turn on 'Always' or 'When in use'\n In Location Services", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { alert in
            if let url = URL(string: "App-Prefs:root=LOCATION_SERVICES") {
                UIApplication.shared.open(url,options: [:], completionHandler:  nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
