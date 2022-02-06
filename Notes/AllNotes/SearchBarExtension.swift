//
//  SearchBarExtension.swift
//  Notes
//
//  Created by F1xTeoNtTsS on 08.10.2021.
//

import UIKit
import CoreData

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        guard let text = searchBar.text else {return}
        let predicate = NSPredicate(format: "text CONTAINS[cd] %@", text)
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
        self.loadNotes(with: request, predicate: predicate)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            self.loadNotes()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.loadNotes()
    }
}
