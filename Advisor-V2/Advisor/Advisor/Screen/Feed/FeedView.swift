//
//  FeedView.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import UIKit

protocol FeedViewProtocol: AnyObject {
    func reloadTableView()
    func showSpinner(show: Bool)
    func showAlertError(message: String)
    func showImageNoData(show: Bool)
    func showOnMapDidTap()
}

class FeedView: UIViewController {
    
    // MARK: Outlets 
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    // MARK: Private properties
    private var flow: Flow?
    
    // MARK: Public properties
    var presenter: FeedPresenterProtocol?
    var configurator = FeedConfigurator()
    var indexFlow: Int?
    var rate: String?
    var kind: String?
    
    // MARK: Main
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        setupNavigationBar()
        setupCollectionView()
        setupTableView()
        setupFlow()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if navigationController?.viewControllers.last?.nibName == "HomeView" {
            tabBarController?.tabBar.isHidden = false
        } else if navigationController?.viewControllers.last?.nibName == "MapView" {
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    // MARK: Private Functions
    private func setupFlow() {
        guard let index = indexFlow else { return }
        flow = presenter?.presentFlow(indexPath: index)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: TableCell.identifier, bundle: nil), forCellReuseIdentifier: TableCell.identifier)
        tableView.register(TableViewHeader.self,
               forHeaderFooterViewReuseIdentifier: "sectionHeader")
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: CategoryCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    
    private func setupNavigationBar() {
        let button = UIButton(type: .system)
        button.configuration = .filled()
        button.tintColor = .purple
        button.setImage(UIImage(systemName: "bolt.heart.fill"), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
}

// MARK: Feed view protocol
extension FeedView: FeedViewProtocol {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showSpinner(show: Bool) {
        DispatchQueue.main.async {
            show ? self.spinner.startAnimating() : self.spinner.stopAnimating()
        }
    }
    
    func showAlertError(message: String) {
        let alert = UIAlertController.init(title: "Something went wrong", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.showSpinner(show: false)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showImageNoData(show: Bool) {
        imageView.isHidden = !show
    }
    
    func showOnMapDidTap() {
        guard let indexFlow = indexFlow else { return }
        presenter?.presentMapViewWith(rate: rate, kind: kind, indexFlow: indexFlow)
    }
}

// MARK: Table delegate
extension FeedView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let attractions = presenter?.getAttractions() else { return }
        
        presenter?.presentDetailView(xid: attractions[indexPath.row].xid)
    }
}

// MARK: Table Data Source
extension FeedView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = presenter?.getAttractions().count else { return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as? TableCell,
              let attractions = presenter?.getAttractions(),
              let name = attractions[indexPath.row].name else { return UITableViewCell()}
        
        cell.configureCell(label: name)
        tableView.separatorStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height = tableView.visibleSize.height / 5
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! TableViewHeader
        view.title.text = presenter?.getHeader()
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

// MARK: Collection Data Source
extension FeedView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let flow = flow else { return 0}
        return flow.collectionViewCellNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell,
                let flow = flow else { return UICollectionViewCell()}
        cell.configureCell(imageName: flow.collectionViewCellImages[indexPath.row], label: flow.collectionViewCellNames[indexPath.row])
        return cell
    }
}

// MARK: Collection delegate
extension FeedView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let flow = flow else { return }
        indexPath.row == 0 ? presenter?.setHeader(header: "Great Spots Near You") : presenter?.setHeader(header: flow.collectionViewCellNames[indexPath.row])
        self.rate = flow.collectionViewCellRequestSubcatRates[indexPath.row]
        self.kind = flow.collectionViewCellRequestSubcatNames[indexPath.row]
        presenter?.presentTableData(rate: flow.collectionViewCellRequestSubcatRates[indexPath.row], kind: flow.collectionViewCellRequestSubcatNames[indexPath.row])
        
        tableView.reloadData()
    }
}

// MARK: Flow Layout
extension FeedView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightInset: CGFloat = 14
        let widthInset: CGFloat = 60
        let height = collectionView.visibleSize.height - heightInset
        let width = collectionView.visibleSize.width - widthInset
        return CGSize(width: width / 3, height: height)
    }
}

