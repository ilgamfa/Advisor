//
//  DetailViewController.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 06.10.2021.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    // MARK: Private
    private var viewModel = AttractionViewModel()
    private let idGoToMapVC = "mapVC"
    private let idSavedVC = "savedVC"
    
    
    // MARK: Public
    var lat: Double = 0.0
    var lon: Double = 0.0
    var name: String = ""
    var isLiked: Bool = false
    
    var detail: AttractionDetail?
    var xid: String = ""

    // MARK: Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var mapButton: UIButton!
    @IBOutlet private weak var likeView: UIView!
    @IBOutlet private weak var likeButtonOutlet: UIButton!
    @IBOutlet private weak var spinnerIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var spinnerView: UIView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail info"
        
        if isLiked {
            likeButtonOutlet.tintColor = .red
        }
        else {
            likeButtonOutlet.tintColor = .darkGray
        }
        
        spinnerView.layer.masksToBounds = false
        spinnerView.layer.cornerRadius = 20
        mapButton.layer.masksToBounds = false
        mapButton.layer.cornerRadius = 30
        likeView.layer.masksToBounds = false
        likeView.layer.cornerRadius = 20
        showSpinner()
        loadDetailData()
        
        
    }
    
    // MARK: Private functions
    @IBAction private func likeButtonDidTap(_ sender: UIButton) {
        
        if likeButtonOutlet.tintColor != .red {
            guard let itemTitle = nameLabel.text, !itemTitle.isEmpty else { return }
            SavedData.shared.saveItem(title: itemTitle, xid: xid)
            likeButtonOutlet.tintColor = .red
        }
        else {
            likeButtonOutlet.tintColor = .darkGray
            SavedData.shared.listITems.removeFirst()
        }
    }
    
    @IBAction func mapButtonDidTap(_ sender: UIButton) {
        guard let mapVC = storyboard?.instantiateViewController(identifier: idGoToMapVC) as? MapViewController else { return }
        mapVC.latitude = lat
        mapVC.longitude = lon
        mapVC.nameTitle = name
        mapVC.detailState = true
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    
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
   
    private func loadDetailData() {
        
        viewModel.fetchDetailData(xid: xid) { [weak self] in
            self?.detail = self!.viewModel.attractionDetail
            
            let nameText = self?.detail?.name == "" ? "No name yet" : self?.detail?.name
            guard let name = nameText else { return }
            
            
            let kinds = self?.detail?.kinds
            
            let descriptionText = self?.detail?.wikipedia_extracts?.text
            
            let state = self?.detail?.address?.state
            guard let stateName = state else {return}

            let imageUrl: String = self!.detail?.preview?.source ?? ""
            if imageUrl == "" {
                self!.hideSpinner()
            }
            
            self!.setImage(imageUrl: imageUrl)
            
            guard let latitude = self!.detail?.point?.lat else { return }
            guard let longitude = self!.detail?.point?.lon else { return }
            self?.lat = latitude
            self?.lon = longitude
            self?.name = name
            
            DispatchQueue.main.async {
                self!.nameLabel.text = name
                self!.descriptionTextView.text = descriptionText == nil ? kinds : descriptionText
                self!.addressLabel.text = stateName
            }
        }
    }
    
    private func setImage(imageUrl: String) {
         
        viewModel.fetchImageData(imageUrl: imageUrl) { [weak self] in
            DispatchQueue.main.async {
                self!.imageView.image = self!.viewModel.detailImage
                self!.imageView.layer.cornerRadius = 30
                self!.imageView.layer.masksToBounds = true
            }
            self!.hideSpinner()
        }
    }
}
