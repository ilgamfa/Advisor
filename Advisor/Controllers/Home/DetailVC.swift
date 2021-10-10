//
//  DetailViewController.swift
//  Advisor
//
//  Created by Ilgam Akhmatdionov on 06.10.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var xid: String = ""
    var name: String = ""
    
    private var viewModel = AttractionViewModel()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var xidLabel: UILabel!
    
    var nameText = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail info"
        
        nameLabel.text = name
        xidLabel.text = xid
        
    }
    
    
//    private func loadDetailData() {
//        viewModel.fetchDetailData(xid: xid) { [weak self] in
//            DispatchQueue.main.async {
//                print(self)
//            }
//        }
//    }
    



}
