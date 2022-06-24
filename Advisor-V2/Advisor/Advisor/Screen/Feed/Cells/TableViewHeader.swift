//
//  TableViewHeader.swift
//  Advisor_V2
//
//  Created by Ильгам Ахматдинов on 01.05.2022.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {
    let title = UILabel()
    let button = UIButton(type: .system)

    weak var delegate: FeedViewProtocol?
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        title.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.tintColor = UIColor(named: "tabBarTint")
        button.setTitle("Показать на карте", for: .normal)
        button.addTarget(self, action: #selector(showOnMap), for: .touchUpInside)
        
        contentView.addSubview(title)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 10),
            button.centerYAnchor.constraint(equalTo: title.centerYAnchor)
        ])
    }
    @objc func showOnMap() {
        delegate?.showOnMapDidTap()
    }
}
