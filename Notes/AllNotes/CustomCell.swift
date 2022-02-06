//
//  CustomCell.swift
//  Notes
//
//  Created by F1xTeoNtTsS on 08.10.2021.
//

import UIKit

class CustomCell: UITableViewCell {

    let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let noteLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView(contentView)
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellView(_ view: UIView){
        let cellStack = UIStackView(arrangedSubviews: [noteLabel,dateLabel])
        cellStack.alignment = .leading
        cellStack.axis = .vertical
        cellStack.spacing = 5
        cellStack.translatesAutoresizingMaskIntoConstraints = false
        cellView.addSubview(cellStack)
        view.addSubview(cellView)
        NSLayoutConstraint.activate([
            
            cellStack.topAnchor.constraint(equalTo: cellView.topAnchor),
            cellStack.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            cellStack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            cellStack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            
            cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cellView.topAnchor.constraint(equalTo: view.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cellView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cellView.heightAnchor.constraint(greaterThanOrEqualToConstant: 70)
        ])
    }
}
