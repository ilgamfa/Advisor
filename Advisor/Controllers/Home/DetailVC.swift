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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail info"
        loadDetailData()
        
    }
    
    
    private func loadDetailData() {
        viewModel.fetchDetailData(xid: xid) { [weak self] in
            self?.detail = self!.viewModel.attractionDetail
            
            let nameText = self?.detail?.name == "" ? "No name yet" : self?.detail?.name
            guard let name = nameText else { return }
            
            let descriptionText = self?.detail?.wikipedia_extracts?.text
            
            let imageUrl: String = self!.detail?.preview?.source ?? "image URl"
         
            self!.setImage(imageUrl: imageUrl)
            
            guard let latitude = self!.detail?.point?.lat else { return }
            guard let longitude = self!.detail?.point?.lon else { return }
            
            DispatchQueue.main.async {
                self!.nameLabel.text = nameText
                self!.descriptionTextView.text = descriptionText == nil ? "No description yet": descriptionText
                self!.setAnnotation(latitude: latitude, longitude: longitude, nameTitle: name)
               
            }
        
        }
    }
    
    
    private func setImage(imageUrl: String) {
        viewModel.downloadData(imageUrl: imageUrl) { [weak self] in
            DispatchQueue.main.async {
                self!.imageView.image = self!.viewModel.detailImage
            }
        }
    }
    
    private func setAnnotation(latitude: Double, longitude: Double, nameTitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = nameTitle

        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(annotation)
    }
    



}
