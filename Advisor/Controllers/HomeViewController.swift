//
//  HomeViewController.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.09.2021.
//

import UIKit


class HomeViewController: UIViewController {
    
    private let reuseIdCell = "cell"
    
    @IBOutlet weak var homeTableView: UITableView!
    
    private var viewModel = AttractionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAttractionsData()
    }
    
    private func loadAttractionsData() {
        viewModel.fetchData { [weak self] in
            self?.homeTableView.dataSource = self
            self?.homeTableView.reloadData()
        }
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdCell, for: indexPath) as! HomeTableViewCell
    
        let attraction = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValues(attraction)
        return cell
    
    }
}
