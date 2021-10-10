//
//  DetailViewController.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 06.10.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detail: AttractionDetail?
    var xid: String = ""
    
    private var viewModel = AttractionViewModel()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var xidLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail info"
//        xidLabel.text = xid
//        loadDetailData()
        
    }
    
    
    private func loadDetailData() {
        viewModel.fetchDetailData(xid: xid) { [weak self] in
            DispatchQueue.main.async {
                self?.detail = self!.viewModel.attractionDetail
                self!.nameLabel.text = self!.detail?.name
            }
        
        }
    }
    



}
