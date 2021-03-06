//
//  ViewController.swift
//  Notes
//
//  Created by F1xTeoNtTsS on 08.10.2021.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    private let notesViewConfiguration = ListView()
    private var notes = [Notes]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        notesViewConfiguration.searchBar.searchBar.delegate = self
        notesViewConfiguration.setView(view)
        setNavBar()
        setTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        loadNotes()
    }

    func setNavBar(){
        navigationItem.title = "Заметки"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = notesViewConfiguration.searchBar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 25)]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }

    func setTableView(){
        notesViewConfiguration.notesTableView.delegate = self
        notesViewConfiguration.notesTableView.dataSource = self
    }
    
// MARK: - CoreData methods
    
    func loadNotes(with request: NSFetchRequest<Notes> = Notes.fetchRequest(), predicate: NSPredicate? = nil){
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            notes = try context.fetch(request)
        } catch {
            print("Failed with loading data \(error.localizedDescription)")
        }
        notesViewConfiguration.notesTableView.reloadData()
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

// MARK: - DataSourse and Delegate methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! CustomCell
        if let date = notes[indexPath.row].date {
            createDateString(cell, date)
        }
        cell.noteLabel.text = notes[indexPath.row].text
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentNote = notes[indexPath.row]
        let selectedNoteVC = NotesViewController()
        passNotesData(to: selectedNoteVC, currentNote)
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

    fileprivate func createDateString(_ cell: CustomCell, _ date: Date) {
        let dateAsString = DateFormatter()
        dateAsString.dateFormat = "dd/MM/yyyy"
        cell.dateLabel.text = dateAsString.string(from: date)
    }
    
    fileprivate func passNotesData(to selectedNoteVC: NotesViewController, _ currentNote: Notes) {
        selectedNoteVC.selectedNote = currentNote
        selectedNoteVC.completion = { [weak self] text, date in
            DispatchQueue.main.async {
                do {
                    selectedNoteVC.selectedNote?.setValue(text, forKey: "text")
                    selectedNoteVC.selectedNote?.setValue(date, forKey: "date")
                    self?.notesViewConfiguration.notesTableView.reloadData()
                    try self?.context.save()
                } catch {
                    print("failed with \(error.localizedDescription)")
                }
            }
        }
    }
}


