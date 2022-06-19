//
//  FafouritesView.swift
//  Advisor
//
//  Created by Ильгам Ахматдинов on 27.04.2022.
//

import UIKit

struct FavoritesObject {
    var xid: String?
    var name: String?
}

protocol FavouritesViewProtocol: AnyObject {
    
}

class FavouritesView: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var notObjectsLabel: UILabel!
    @IBOutlet private weak var labelTopConstraint: NSLayoutConstraint!
    
    var presenter: FavouritesPresenterProtocol?
    var configurator = FavouritesConfigurator()
    var store = StoreService()
    var favorites = [FavoritesObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        setupTableView()
        setupNavigationBar()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupObjects()
        
        if navigationController?.viewControllers.count == 1 {
            backButton.isHidden = true
        }
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func hideMessageLabel(hide: Bool) {
       notObjectsLabel.isHidden = hide
    }
    
    private func setupObjects() {
        favorites.removeAll()
        store.getAttractions { result in
            switch result {
            case .success(let attractions):
                attractions.forEach { attaction in
                    self.favorites.append(FavoritesObject(xid: attaction.xid, name: attaction.name))
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
            self.tableView.reloadData()
            self.hideMessageLabel(hide: !self.favorites.isEmpty)
        }
    }
    
    private func setupTableView() {
        let height = tableView.visibleSize.height / 5
        labelTopConstraint.constant += height
        let headerView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: height))
        self.tableView.tableHeaderView = headerView
        headerView.imageView.image = UIImage(named: "kazan")
        headerView.label.text = "Избранное"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: TableCell.identifier, bundle: nil), forCellReuseIdentifier: TableCell.identifier)
        tableView.register(TableViewHeader.self,
               forHeaderFooterViewReuseIdentifier: "sectionHeader")
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        backButton.tintColor = .white
    }
    @IBAction func backButtonDidTap(_ sender: Any) {
        presenter?.dismissScreen()
    }
}

extension FavouritesView: FavouritesViewProtocol {
    
}

extension FavouritesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.presentDetailView(xid: favorites[indexPath.row].xid!)
    }
}

extension FavouritesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as? TableCell else { return UITableViewCell() }
        cell.configureCell(label: favorites[indexPath.row].name ?? "")
        tableView.separatorStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height = tableView.visibleSize.height / 7
        return height
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let xid = favorites[indexPath.row].xid {
                store.deleteAttraction(xid: xid)
                favorites.remove(at: indexPath.row)
                hideMessageLabel(hide: !favorites.isEmpty)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if editingStyle == .insert {

        }
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
//            -> UISwipeActionsConfiguration? {
//            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
//                if let xid = self.favorites[indexPath.row].xid {
//                    self.store.deleteAttraction(xid: xid)
//
//                    completionHandler(true)
//                }
//
//            }
//            deleteAction.image = UIImage(systemName: "trash")
//            deleteAction.backgroundColor = .systemRed
//            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
//            return configuration
//    }
    
}

extension FavouritesView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? StretchyTableHeaderView else { return }
        header.scrollViewDidScroll(scrollView: scrollView)
    }
}
