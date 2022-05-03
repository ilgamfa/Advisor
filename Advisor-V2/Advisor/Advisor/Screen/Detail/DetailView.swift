//
//  DetailView.swift
//  Advisor_V2
//
//  Created by Ильгам Ахматдинов on 02.05.2022.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func configureDetailFlow(image: UIImage?, title: String, description: String)
}

class DetailView: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var objectLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var xid: String?
    
    var presenter: DetailPresenterProtocol?
    var configurator = DetailConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(view: self)

        setupDetailFlow()
        
    }
    
    private func setupDetailFlow() {
        guard let xid = xid else { return }
        presenter?.presentFlow(xid: xid)
    }
}

extension DetailView: DetailViewProtocol {
    func configureDetailFlow(image: UIImage?, title: String, description: String) {
        DispatchQueue.main.async {
            self.objectLabel.text = title
            self.descriptionLabel.text = description
            guard let image = image else {
                return
            }
            self.imageView.image = image
        }
    }
}
