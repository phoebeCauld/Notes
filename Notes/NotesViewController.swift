//
//  NotesViewController.swift
//  Notes
//
//  Created by F1xTeoNtTsS on 08.10.2021.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    
    private let configurations = NotesView()
    private var textNote = [Notes]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let doneButton = DoneButton(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
    override func viewDidLoad() {
        super.viewDidLoad()
        configurations.setView(view)
        configurations.textView.becomeFirstResponder()
        setTextView()
        setNavBar()
    }

    func setNavBar(){
        navigationItem.rightBarButtonItem = doneButton
        doneButton.hideDoneButton()
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
        doneButton.hideDoneButton()
    }
}

extension NotesViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        doneButton.showDoneButton()
    }
}
