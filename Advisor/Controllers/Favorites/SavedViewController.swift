//
//  SavedViewController.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 28.09.2021.
//

import UIKit

class SavedViewController: UIViewController {

    
    // MARK: Public
    var name: String = ""
    
    // MARK: Private
    private var reuseTableIdCell = "savedCell"
    private let goToDetailController = "detailVC"
    
    // MARK: Outlets
   
    @IBOutlet private weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    

}


// MARK: UI TableView Delegate

extension SavedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(identifier: goToDetailController) as? DetailViewController else {
            return
        }
        detailVC.xid = SavedData.shared.listITems[indexPath.row].itemXid
        detailVC.isLiked = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SavedData.shared.listITems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: UI TableView DataSource
extension SavedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SavedData.shared.listITems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseTableIdCell, for: indexPath) as! SavedItemTVCell
        
        cell.tableViewCellLabel.text = SavedData.shared.listITems[indexPath.row].itemTitle

        cell.viewTableCell.layer.cornerRadius = 10
        cell.viewTableCell.layer.borderWidth = 0.5
        cell.viewTableCell.layer.borderColor = UIColor.lightGray.cgColor
        cell.viewTableCell.layer.shadowOffset = CGSize(width: 1, height: 2)
        cell.viewTableCell.layer.shadowRadius = 3
        cell.viewTableCell.layer.masksToBounds = false
        return cell
    }
}
