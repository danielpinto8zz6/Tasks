//
//  NotesListTableViewController.swift
//  Tasks
//
//  Created by daniel on 26/08/2018.
//  Copyright © 2018 daniel. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {
    
    var mode = 0

    @IBOutlet weak var UISegmentedControl: UISegmentedControl!
    @IBAction func ToggleEdit(_ sender: Any) {
        toggleEditMode()
    }
    @IBAction func ShowMode(_ sender: Any) {
        let index = UISegmentedControl.selectedSegmentIndex
        
        switch (index) {
        case 0:
            mode = 0
            tableView.reloadData()
        case 1:
            mode = 1
            tableView.reloadData()
        case 2:
            mode = 2
            tableView.reloadData()
        case 3:
            mode = 3
            tableView.reloadData()
        default:
            return
        }
    }
    
    var notes : [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.object(forKey: "tasks") as? NSData {
            notes = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Note]
        }
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        saveTasks()
        
        sort(mode: .byDateAscending)

        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveTasks()
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let note = notes[sourceIndexPath.row]
        notes.remove(at: sourceIndexPath.row)
        notes.insert (note, at: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "showNote" {
            let noteDetailViewController = segue.destination as! NoteDetailViewController
            var selectedIndexPath = tableView.indexPathForSelectedRow
            noteDetailViewController.note = notes[selectedIndexPath!.row]
        } else if segue.identifier! == "addNote" {
            let note = Note()
            notes.append(note)
            let noteDetailViewController = segue.destination as! NoteDetailViewController
            noteDetailViewController.note = note
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        
        let done = UITableViewRowAction(style: .default, title: "Done") { (action, indexPath) in
            self.notes[indexPath.row].state = "done"
            tableView.reloadData()
        }
        
        let inProgress = UITableViewRowAction(style: .default, title: "In progress") { (action, indexPath) in
            self.notes[indexPath.row].state = "inProgress"
            tableView.reloadData()
        }
        
        done.backgroundColor = UIColor.green
        inProgress.backgroundColor = UIColor.yellow
        
        switch notes[indexPath.row].state {
        case "done":
            return [delete]
        case "inProgress":
            return [delete, done]
        case "undone":
            return [delete, done, inProgress]
        default:
            return [delete, done, inProgress]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)
        
        cell.textLabel?.text = notes[indexPath.row].title
        cell.detailTextLabel?.text = notes[indexPath.row].dateToString
        
        if (notes[indexPath.row].state == "done") {
            cell.detailTextLabel?.textColor = UIColor.green
        } else if (notes[indexPath.row].state == "inProgress") {
            cell.detailTextLabel?.textColor = UIColor.yellow
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var rowHeight = 40
        
        switch mode {
        case 0:
            return CGFloat(rowHeight)
        case 1:
        if (notes[indexPath.row].state != "undone") {
            return 0
        }
        case 2:
        if (notes[indexPath.row].state != "inProgress") {
            return 0
        }
        case 3:
        if (notes[indexPath.row].state != "done") {
            return 0
        }
        default:
            return CGFloat(rowHeight)
        }

        return CGFloat(rowHeight)
    }
    
    func sort (mode: SortMode) {
        switch mode {
        case .byDateAscending:
            if (self.notes.count > 1){
                self.notes = self.notes.sorted(by: {
                    $0.date?.compare($1.date as! Date) == .orderedAscending
                })
            }
        case .byDateDescending:
            if (self.notes.count > 1){
                self.notes = self.notes.sorted(by: {
                    $0.date?.compare($1.date as! Date) == .orderedDescending
                })
            }
        }
    }
    
    func saveTasks() {
        if (!notes.isEmpty) {
            let data = NSKeyedArchiver.archivedData(withRootObject: notes)
            UserDefaults.standard.set(data, forKey: "tasks")
        }
    }
    
    func toggleEditMode () {
        if (tableView.isEditing) {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
        
    }
}

enum SortMode {
    case byDateAscending
    case byDateDescending
}
