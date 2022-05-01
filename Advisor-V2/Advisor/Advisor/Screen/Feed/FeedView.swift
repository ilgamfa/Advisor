//
//  FeedView.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.04.2022.
//

import UIKit

protocol FeedViewProtocol: AnyObject {
    
}

class FeedView: UIViewController {
    
    // MARK: Outlets 
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: FeedPresenterProtocol?
    var configurator = FeedConfigurator()
    var indexFlow: Int?
    
    private var flow: Flow?
    
    // MARK: Main
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator.configure(view: self)
        setupCollectionView()
        setupTableView()
        setupFlow()
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
}

// MARK: Feed view protocol
extension FeedView: FeedViewProtocol {
    
}

// MARK: Table delegate
extension FeedView: UITableViewDelegate {
    
}

// MARK: Table Data Source
extension FeedView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as? TableCell else { return UITableViewCell()}
        cell.configureCell(label: "test name")
        tableView.separatorStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height = tableView.visibleSize.height / 4
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                "sectionHeader") as! TableViewHeader
        view.title.text = "Great Spots Near You"
        return view
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

