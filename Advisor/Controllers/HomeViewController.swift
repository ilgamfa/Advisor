//
//  HomeViewController.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.09.2021.
//

import UIKit


class HomeViewController: UIViewController {
    
    // MARK: private 
    private let reuseIdCell = "cell"
    private var viewModel = AttractionViewModel()
    
    // MARK: Outlet
    @IBOutlet private weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.dataSource = self
        homeTableView.delegate = self
        loadAttractionsData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func loadAttractionsData() {
        viewModel.fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.homeTableView.reloadData()
            }
            
        }
    }
    
    
    

}

// MARK: Data source
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

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(identifier: "detailVC") as? DetailViewController else {
            return
        }
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
