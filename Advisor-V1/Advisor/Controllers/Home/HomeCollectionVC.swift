//
//  HomeViewController.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.09.2021.
//

import UIKit
import MapKit
import Network

class HomeCollectionViewController: UIViewController {

    // MARK: private
    private var collectionNames = [
        "Interesting places",
        "Tourist facilities",
        "Amusements",
        "Accommodations",
        "Sport",
        "Adult"
    ]
    
    private var collectionImages = [
        UIImage(named: "interestingPlaces"),
        UIImage(named: "touristFacilities"),
        UIImage(named: "amusements"),
        UIImage(named: "accommodations"),
        UIImage(named: "sport"),
        UIImage(named: "adult")
    ]
    
    private let reuseIdCell = "collectionCell"
    private let goToControllerId = "TableItemVC"
    
    private let locationService = LocationService()
    
    
    private let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")

    
    // MARK: Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationService.locationManager.requestWhenInUseAuthorization()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                DispatchQueue.main.async {
                    self.showAlert(title: "Something wrong with internet connection", message: "Check the internet connection")
                }
                
            }
        }
        monitor.start(queue: queue)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: Private functions
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        
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


// MARK: UI CollectionView Delegate

extension HomeCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let feedItemsVC = storyboard?.instantiateViewController(identifier: goToControllerId) as? FeedItemsVC else {
            return
        }
        feedItemsVC.selfIndexPath = indexPath.row

        feedItemsVC.title = collectionNames[indexPath.row]

        navigationController?.pushViewController(feedItemsVC, animated: true)
        
    }
}

// MARK: UI CollectionView DataSource

extension HomeCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdCell, for: indexPath) as! HomeCVCell
        cell.collectionLabel.text = collectionNames[indexPath.row]
        cell.collectionImage.image = collectionImages[indexPath.row]
        
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

// MARK: UICollectionViewDelegateFlowLayout
extension HomeCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.height
        let width = view.frame.width
        return CGSize(width: width * 0.42, height: height * 0.245)
    }
}

extension HomeCollectionViewController: CLLocationManagerDelegate {
    
}
