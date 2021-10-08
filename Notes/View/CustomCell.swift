//
//  CustomCell.swift
//  Notes
//
//  Created by F1xTeoNtTsS on 08.10.2021.
//

//import UIKit
//
//class CustomCell: UITableViewCell {
//    let configSearch = ListView()
//    let cellView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 10
//        view.backgroundColor = .darkGray
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupCellView(contentView)
//        contentView.backgroundColor = .black
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupCellView(_ view: UIView){
//        cellView.addSubview(configSearch.searchBar.searchBar)
//        configSearch.searchBar.searchBar.searchTextField.backgroundColor = .clear
//        view.addSubview(cellView)
//        NSLayoutConstraint.activate([
//            
//            configSearch.searchBar.searchBar.topAnchor.constraint(equalTo: cellView.topAnchor,
//                                                                 constant: 10),
//            configSearch.searchBar.searchBar.bottomAnchor.constraint(equalTo: cellView.bottomAnchor,
//                                            constant: -10),
//            configSearch.searchBar.searchBar.leadingAnchor.constraint(equalTo: cellView.leadingAnchor,
//                                                                     constant: 10),
//            configSearch.searchBar.searchBar.trailingAnchor.constraint(equalTo: cellView.trailingAnchor,
//                                                                      constant: -10),
//            
//            cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            cellView.topAnchor.constraint(equalTo: view.topAnchor),
//            cellView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
//                                            constant: -10),
//            cellView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            cellView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            cellView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
//        ])
//    }
//
//}
