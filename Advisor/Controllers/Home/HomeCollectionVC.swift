//
//  HomeViewController.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.09.2021.
//

import UIKit
import MapKit

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
    
    private let locationManager = CLLocationManager()
    

    
    // MARK: Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    // MARK: Private functions
    
    private func checkLocationEnabled() {
        let status = locationManager.authorizationStatus
        
        if !CLLocationManager.locationServicesEnabled() {
            showAlert(title: "Device location is unavailable", message: "Do you want to turn on?")
        }
        
        else if status != .authorizedAlways && status != .authorizedWhenInUse {
            showAlert(title: "Advisor needs permission access to your location", message: "Please turn on 'Always' or 'When in use'\n In Location Services")
        }
        else {
            setupManager()
        }
    }

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

    private func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}



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

extension HomeCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.height
        let width = view.frame.width
        return CGSize(width: width * 0.42, height: height * 0.245)
    }
}

extension HomeCollectionViewController: CLLocationManagerDelegate {
    
}
