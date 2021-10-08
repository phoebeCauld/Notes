//
//  NotesViewController.swift
//  Notes
//
//  Created by F1xTeoNtTsS on 08.10.2021.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    
    let configurations = NotesView()
    var textNote = [Notes]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
    override func viewDidLoad() {
        super.viewDidLoad()
        configurations.setView(view)
        setNavBar()
    }

    func setNavBar(){
        navigationItem.rightBarButtonItem = doneButton
        hideDoneButton()
    }
    
    func hideDoneButton(){
        doneButton.isEnabled = false
        doneButton.tintColor = .clear
    }
    
    func showDoneButton(){
        doneButton.isEnabled = true
        doneButton.tintColor = .white
    }
    func setTextView(){
        configurations.textView.delegate = self
    }
// MARK: - CoreDataMethods
    func saveNote(){
        do {
            try context.save()
            print("Saved")
        } catch {
            print("Failed with saving data \(error.localizedDescription)")
        }
    }
    
    @objc func doneButtonPressed(){
        let newNote = Notes(context: self.context)
        newNote.text = configurations.textView.text
        newNote.date = Date()
        configurations.textView.endEditing(true)
        saveNote()
        hideDoneButton()
    }
}


extension NotesViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
}
