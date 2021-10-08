//
//  ViewController.swift
//  Notes
//
//  Created by F1xTeoNtTsS on 08.10.2021.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    let notesViewConfiguration = ListView()
    var notes = [Notes]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        notesViewConfiguration.setView(view)
        setNavBar()
        setTableView()
        loadNotes()
    }

    override func viewWillAppear(_ animated: Bool) {
        loadNotes()
        notesViewConfiguration.notesTableView.reloadData()
    }
    
    func setNavBar(){
        navigationItem.title = "Заметки"
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.searchController = notesViewConfiguration.searchBar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 25, weight: .black)]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .black
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }

    func setTableView(){
        notesViewConfiguration.notesTableView.delegate = self
        notesViewConfiguration.notesTableView.dataSource = self
    }
    
// MARK: - CoreData methods
    
    func loadNotes(){
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            notes = try context.fetch(request)
        } catch {
            print("Failed with loading data \(error.localizedDescription)")
        }
    }
    
    func saveNotes(){
        do {
            try context.save()
        } catch  {
            print("Failed with saving data \(error.localizedDescription)")
        }
    }
    
// MARK: - Actions methods
    
    @objc func addButtonPressed(){
        let notesVC = NotesViewController()
        navigationController?.pushViewController(notesVC, animated: true)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
            cell.textLabel?.text = notes[indexPath.row].text
            cell.backgroundColor = .black
            cell.textLabel?.textColor = .white
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentNote = notes[indexPath.row]
        let selectedNoteVC = SelectedNotesViewController(selectedNote: currentNote)
        selectedNoteVC.completion = { [weak self] text in
            DispatchQueue.main.async {
                do {
                    selectedNoteVC.selectedNote?.setValue(text, forKey: "text")
                    self?.notesViewConfiguration.notesTableView.reloadData()
                    try self?.context.save()
                    print("update text")
                } catch {
                    print("failed with \(error.localizedDescription)")
                }
            }
        }
//        if let selectedNotesText = currentNote.text {
//            selectedNoteVC.text = selectedNotesText
//            selectedNoteVC.selectedNote = currentNote
//            selectedNoteVC.selectedNotes.textView.text = selectedNotesText
//        }
        navigationController?.pushViewController(selectedNoteVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(notes[indexPath.row])
        notes.remove(at: indexPath.row)
        saveNotes()
        tableView.reloadData()
    }
   
    
}
