//
//  DoneButton.swift
//  Notes
//
//  Created by F1xTeoNtTsS on 10.10.2021.
//

import UIKit

class DoneButton: UIBarButtonItem {

    func hideDoneButton(){
        self.isEnabled = false
        self.tintColor = .clear
    }
    func showDoneButton(){
        self.isEnabled = true
        self.tintColor = .white
    }
}
