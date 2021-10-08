//
//  SelectedNotesView.swift
//  Notes
//
//  Created by F1xTeoNtTsS on 08.10.2021.
//

import UIKit

class SelectedNotesView: UIView {
    let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.backgroundColor = .black
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    func setView(_ view: UIView){
        view.addSubview(textView)
        setConstraints(view)
    }
    
    func setConstraints(_ view: UIView){
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
