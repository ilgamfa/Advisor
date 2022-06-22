//
//  DetailView.swift
//  Advisor_V2
//
//  Created by Ильгам Ахматдинов on 02.05.2022.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func setButtonState(isExist: Bool)
    func configureDetailFlow(model: AttractionDetailModel, isExist: Bool)
    func showIndicator(show: Bool)
}

class DetailView: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var objectLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var showOnMapButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    private var kinds = String()
    private var point: Point?
    
    var xid: String?
    
    var presenter: DetailPresenterProtocol?
    var configurator = DetailConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configurator.configure(view: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDetailFlow()
    }

    override func viewWillDisappear(_ animated: Bool) {
        if navigationController?.viewControllers.count == 1 && (navigationController?.viewControllers.last?.nibName == "MapView" || navigationController?.viewControllers.last?.nibName == "FavouritesView") {
            tabBarController?.tabBar.isHidden = false
        }
    }
    
    private func setupDetailFlow() {
        guard let xid = xid else { return }
        presenter?.presentFlow(xid: xid)
    }
    
    private func setupNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        let button = UIButton(type: .system)
        button.configuration = .filled()
        button.tintColor = UIColor(named: "tabBarTint")
        button.setImage(UIImage(systemName: "bolt.heart.fill"), for: .normal)
        button.addTarget(self, action: #selector(presentFavourites), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func presentFavourites() {
        presenter?.presentFavourites()
    }
    
    @IBAction func showOnMapDidTap(_ sender: Any) {
        presenter?.presentMap(model: AttractionDetail(xid: xid,
                                                      name: objectLabel.text,
                                                      address: nil,
                                                      kinds: kinds,
                                                      preview: nil,
                                                      wikipedia_extracts: nil,
                                                      point: point))
    }
    
    @IBAction func saveDidTap(_ sender: Any) {
        guard let xid = xid else { return }
       
        
        presenter?.saveDidTap(xid: xid, name: objectLabel.text)
    }
}

extension DetailView: DetailViewProtocol {
    func showIndicator(show: Bool) {
        show ? spinner.startAnimating() : spinner.stopAnimating()
        saveButton.isHidden = show
        showOnMapButton.isHidden = show
    }
    
    func setButtonState(isExist: Bool) {
        if isExist {
            self.saveButton.tintColor = .red
            self.saveButton.setTitle("В избранном", for: .normal)
        } else {
            self.saveButton.tintColor = UIColor(named: "tabBarTint")
            self.saveButton.setTitle("В избранное", for: .normal)
        }
    }
    
    func configureDetailFlow(model: AttractionDetailModel, isExist: Bool) {
        DispatchQueue.main.async {
            self.showOnMapButton.tintColor = UIColor(named: "tabBarTint")
            self.showOnMapButton.setTitle("Показать на карте", for: .normal)
            self.setButtonState(isExist: isExist)
            self.point = model.attractionDetail.point
            self.objectLabel.text = model.attractionDetail.name ?? "Пока нет названия"
            self.kinds = model.attractionDetail.kinds ?? ""
            self.descriptionLabel.text = model.attractionDetail.wikipedia_extracts?.text ?? self.kinds
            self.addressLabel.text = "\( model.attractionDetail.address?.state ?? "") \(model.attractionDetail.address?.city ?? "") \(model.attractionDetail.address?.road ?? "") \(model.attractionDetail.address?.house_number ?? "")"
            guard let image = model.objectImage else { return }
            self.imageView.image = image
        }
    }
}
