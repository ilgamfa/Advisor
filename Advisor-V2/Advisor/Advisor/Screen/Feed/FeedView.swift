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
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: FeedPresenterProtocol?
    var configurator = FeedConfigurator()
    var indexPath: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator.configure(view: self)
        setupCollectionView()
        setupTableView()
        
        self.title = "hello"
    }
        
    private func setupFlow() {
        guard let index = indexPath else { return }
        presenter?.presentFlow(indexPath: index)
    }
    
    private func setupTableView() {
        
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: CategoryCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifier)
    }
}

extension FeedView: FeedViewProtocol {
    
}

extension FeedView: UITableViewDelegate {
    
}

extension FeedView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension FeedView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell()}
        cell.configureCell(imageName: "culture", label: "label")
        return cell
    }
}

extension FeedView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightInset: CGFloat = 10
        let widthInset: CGFloat = 60
        let height = collectionView.visibleSize.height - heightInset
        let width = collectionView.visibleSize.width - widthInset
        return CGSize(width: width / 3, height: height)
    }
}

