//
//  HomeView.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    
}

class HomeView: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var presenter: HomePresenterProtocol?
    var configurator = HomeConfigurator()
    
    // MARK: Main
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator.configure(view: self)
        setupCollectionView()
        setupNavigationBar()
    }
    
    // MARK: Private functions
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: CategoryCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    
    private func setupNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: Home view protocol
extension HomeView: HomeViewProtocol {
    
}

// MARK: Delegate
extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell else { return }
        let title = cell.getTitle()
        presenter?.presentFeedView(title: title, indexFlow: indexPath.row)
    }
}

// MARK: Data source
extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell,
              let models = presenter?.getCategoryModels() else { return UICollectionViewCell()}
        
        
        cell.configureCell(imageName: models[indexPath.row].categoryImageName, label: models[indexPath.row].categoryLabel)
        return cell
    }
}

// MARK: Flow layout
extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightInset: CGFloat = 35
        let widthInset: CGFloat = 48
        let height = collectionView.visibleSize.height - heightInset
        let width = collectionView.visibleSize.width - widthInset
        return CGSize(width: width / 2, height: height / 3)
    }
}
