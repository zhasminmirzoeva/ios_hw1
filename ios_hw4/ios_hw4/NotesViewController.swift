//
//  NotesViewController.swift
//  ios_hw4
//
//  Created by Zhasmin Mirzoeva on 20.11.2022.
//

import UIKit

protocol AddNoteDelegate {
    func newNoteAdded(note: ShortNote)
}

final class NotesViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    var count: Int = 0
    var dataSource = [ShortNote]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(AddNoteCell.self, forCellReuseIdentifier:
        AddNoteCell.reuseIdentifier)
        tableView.register(NoteCell.self, forCellReuseIdentifier:
        NoteCell.reuseIdentifier)
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    private func setupView() {
        setupTableView()
        setupNavBar()
    }
    private func setupNavBar() {
        self.title = "Notes"
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(dismissViewController(_:)),
        for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView:
        closeButton)
    }
    @objc private func dismissViewController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.pin(to: self.view, [.left, .right, .top, .bottom])
    }
    
    
    private func handleDelete(indexPath: IndexPath) {
        UserDefaults.standard.removeObject(forKey: "\(indexPath.row)")
        tableView.reloadData()
        
    }
}
extension NotesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch section {
        case 0:
            return 1
        default:
            return UserDefaults.standard.dictionaryRepresentation().count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier:
    AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            let note = ShortNote(text: UserDefaults.standard.string(forKey: "\(indexPath.row)"))
            if let noteCell = tableView.dequeueReusableCell(withIdentifier:
            NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
                noteCell.configure(note)
                return noteCell
             }
    }
        return UITableViewCell()
    }
}
extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
    indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: .none
        ) { [weak self] (action, view, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        deleteAction.image = UIImage(
            systemName: "trash.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
        )?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension NotesViewController: AddNoteDelegate {
    func newNoteAdded(note: ShortNote) {
        UserDefaults.standard.set(note.text, forKey: "\(UserDefaults.standard.dictionaryRepresentation().count)")
        tableView.reloadData()
        
    }
}




