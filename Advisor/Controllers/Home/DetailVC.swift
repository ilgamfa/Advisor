//
//  DetailViewController.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 06.10.2021.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    var detail: AttractionDetail?
    var xid: String = ""
    
    private var viewModel = AttractionViewModel()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapButtonDidTap: UIButton!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var likeButtonOutlet: UIButton!
    
    @IBOutlet weak var spinnerIndicator: UIActivityIndicatorView!
    @IBOutlet weak var spinnerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail info"
        spinnerView.layer.masksToBounds = false
        spinnerView.layer.cornerRadius = 20
        mapButtonDidTap.layer.masksToBounds = false
        mapButtonDidTap.layer.cornerRadius = 30
        likeView.layer.masksToBounds = false
        likeView.layer.cornerRadius = 20
        
        loadDetailData()
        
        
    }
    
    @IBAction func likeButtonDidTap(_ sender: UIButton) {
        if likeButtonOutlet.tintColor != .red {
            likeButtonOutlet.tintColor = .red
        }
        else {
            likeButtonOutlet.tintColor = .darkGray
        }
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
        showSpinner()
        viewModel.fetchDetailData(xid: xid) { [weak self] in
            self?.detail = self!.viewModel.attractionDetail
            
            let nameText = self?.detail?.name == "" ? "No name yet" : self?.detail?.name
            guard let name = nameText else { return }
            
            let kinds = self?.detail?.kinds
            
            let descriptionText = self?.detail?.wikipedia_extracts?.text
            
            let imageUrl: String = self!.detail?.preview?.source ?? "image URl"
         
            self!.setImage(imageUrl: imageUrl)
            
            guard let latitude = self!.detail?.point?.lat else { return }
            guard let longitude = self!.detail?.point?.lon else { return }
            
            DispatchQueue.main.async {
                
                self!.nameLabel.text = nameText
                self!.descriptionTextView.text = descriptionText == nil ? kinds : descriptionText
                self!.setAnnotation(latitude: latitude, longitude: longitude, nameTitle: name)
                self!.hideSpinner()
            }
        
        }
    }
    
    
    private func setImage(imageUrl: String) {
        viewModel.downloadData(imageUrl: imageUrl) { [weak self] in
            DispatchQueue.main.async {
                self!.imageView.image = self!.viewModel.detailImage
                self!.imageView.layer.cornerRadius = 30
                self!.imageView.layer.masksToBounds = true
            }
        }
    }
    
    private func setAnnotation(latitude: Double, longitude: Double, nameTitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = nameTitle

//        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
//        mapView.setRegion(coordinateRegion, animated: true)
//        mapView.addAnnotation(annotation)
    }
    



}
