//
//  SettingsView.swift
//  Advisor_V2
//
//  Created by Ilgam Akhmatdinov on 04.06.2022.
//

import UIKit

class SettingsView: UIViewController {
    
    @IBOutlet weak var segmentedControlMapType: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var segmentedControlRate: UISegmentedControl!
    
    weak var delegate: MapViewProtocol?
    var selectedIndex = 0
    let categoryModels: [CategoryModel] = [
        CategoryModel(categoryImageName: "interestingPlaces", categoryLabel: "Что-то интересное"),
        CategoryModel(categoryImageName: "touristFacilities", categoryLabel: "Для туристов"),
        CategoryModel(categoryImageName: "amusements", categoryLabel: "Развлечения"),
        CategoryModel(categoryImageName: "accommodations", categoryLabel: "Жилье"),
        CategoryModel(categoryImageName: "sport", categoryLabel: "Спорт"),
        CategoryModel(categoryImageName: "adult", categoryLabel: "Для взрослых"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        segmentedControlMapType.selectedSegmentIndex = selectedIndex
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: CategoryCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    
    @IBAction func changeSegmentControlValue(_ sender: Any) {
        delegate?.changeMapType(index: segmentedControlMapType.selectedSegmentIndex)
    }
}


// MARK: Delegate
extension SettingsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
            cell.setSelectedLayer(selected: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
            cell.setSelectedLayer(selected: false)
        }
    }
}

// MARK: Data source
extension SettingsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell()}
        cell.configureCell(imageName: categoryModels[indexPath.row].categoryImageName, label: categoryModels[indexPath.row].categoryLabel)
        return cell
    }
}

// MARK: Flow layout
extension SettingsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightInset: CGFloat = 10
        let widthInset: CGFloat = 48
        let height = collectionView.visibleSize.height - heightInset
        let width = collectionView.visibleSize.width - widthInset
        return CGSize(width: width / 3, height: height)
    }
}
