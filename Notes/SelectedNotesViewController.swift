//
//  SelectedNotesViewController.swift
//  Notes
//
//  Created by F1xTeoNtTsS on 08.10.2021.
//

import UIKit
import CoreData
class SelectedNotesViewController: UIViewController {
    public var completion: ((String?, Date?) -> Void)?
    var selectedNote: NSManagedObject?
    
    init(selectedNote: NSManagedObject) {
        self.selectedNote = selectedNote
        super.init(nibName: nil, bundle: nil)
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let selectedNotes = SelectedNotesView()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedNotes.setView(view)
        setTextView()
        setupNavBar()
        selectedNotes.textView.text = selectedNote?.value(forKey: "text") as? String
    }
    
    func setTextView(){
        selectedNotes.textView.delegate = self
    }
    func setupNavBar(){
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
// MARK: - Action Meethods
    @objc func doneButtonPressed(){
        let date = Date()
        guard let text = selectedNotes.textView.text, selectedNotes.textView.hasText else {
            hideDoneButton()
            selectedNotes.textView.endEditing(true)
            // NEED TO CHANGE DATE TO SAME IF TEXT NOT CHANGED
            return editText("", date)
        }
        editText(text, date)
        selectedNotes.textView.endEditing(true)
        hideDoneButton()
    }
    
    func editText(_ text: String, _ date: Date){
        completion?(text, date)
    }
}

extension SelectedNotesViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        showDoneButton()
    }
}
