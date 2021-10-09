//
//  ListView.swift
//  Notes
//
//  Created by F1xTeoNtTsS on 08.10.2021.
//

import UIKit

class ListView: UIView {

    let notesTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.register(CustomCell.self, forCellReuseIdentifier: K.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let searchBar: UISearchController = {
        let sb = UISearchController()
        sb.searchBar.searchBarStyle = .prominent
        sb.searchBar.placeholder = "Поиск"
        sb.searchBar.sizeToFit()
        sb.searchBar.searchTextField.backgroundColor = .clear
        sb.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    func setView(_ view: UIView){
        addSubview(view)
        setupConstraints(view)
    }
    
    override func addSubview(_ view: UIView) {
        view.addSubview(notesTableView)
        
    }
    
    func setupConstraints(_ view: UIView){
        NSLayoutConstraint.activate([
            notesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            notesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: 10),
            notesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -10),
            notesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
