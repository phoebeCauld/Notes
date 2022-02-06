//
//  NotesViewController.swift
//  Notes
//
//  Created by F1xTeoNtTsS on 08.10.2021.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    
    
    public var completion: ((String?, Date?) -> Void)?
    var selectedNote: NSManagedObject?
    
    private let notesView = NotesView()
    private var textNote = [Notes]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let doneButton = DoneButton(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesView.setView(view)
        notesView.textView.becomeFirstResponder()
        setTextView()
        setNavBar()
    }

    func setNavBar(){
        navigationItem.rightBarButtonItem = doneButton
        doneButton.hideDoneButton()
    }
    
    func setTextView(){
        notesView.textView.delegate = self
        if let selectedNote = selectedNote {
            notesView.textView.text = selectedNote.value(forKey: "text") as? String
        }
    }

    @objc func doneButtonPressed(){
        if let _ = selectedNote {
            updateSelectedNote()
        } else {
            let newNote = Notes(context: self.context)
            newNote.text = notesView.textView.text
            newNote.date = Date()
            notesView.textView.endEditing(true)
            saveNote()
            doneButton.hideDoneButton()
        }
    }
    
    private func updateSelectedNote() {
        let date = Date()
        guard let text = notesView.textView.text, notesView.textView.hasText else {
            doneButton.hideDoneButton()
            notesView.textView.endEditing(true)
            // NEED TO CHANGE DATE TO SAME IF TEXT NOT CHANGED
            return editText("", date)
        }
        editText(text, date)
        notesView.textView.endEditing(true)
        doneButton.hideDoneButton()
    }
    
    private func editText(_ text: String, _ date: Date){
        completion?(text, date)
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
}

extension NotesViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        doneButton.showDoneButton()
    }
}
