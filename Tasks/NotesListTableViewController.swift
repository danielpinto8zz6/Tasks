//
//  NotesListTableViewController.swift
//  Tasks
//
//  Created by daniel on 26/08/2018.
//  Copyright © 2018 daniel. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {

    var notes : [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*if let savedTasks = UserDefaults.standard.object(forKey: "taskss") as? NSData {
            notes = NSKeyedUnarchiver.unarchiveObject(with: savedTasks as Data) as! [Note]
        }*/
        
        //self.tableView.isEditing = true
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sort(mode: .byDateAscending)

        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        /*let data = NSKeyedArchiver.archivedData(withRootObject: notes)
        UserDefaults.standard.set(data, forKey: "taskss")*/
    }
    
    /* override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete;
    } */
    
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
            self.notes[indexPath.row].state = .done
            tableView.reloadData()
        }
        
        let inProgress = UITableViewRowAction(style: .default, title: "In progress") { (action, indexPath) in
            self.notes[indexPath.row].state = .inProgress
            tableView.reloadData()
        }
        
        done.backgroundColor = UIColor.green
        inProgress.backgroundColor = UIColor.yellow
        
        switch notes[indexPath.row].state {
        case .done:
            return [delete]
        case .inProgress:
            return [delete, done]
        case .undone:
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
        
        if (notes[indexPath.row].state == .done) {
            cell.detailTextLabel?.textColor = UIColor.green
        } else if (notes[indexPath.row].state == .inProgress) {
            cell.detailTextLabel?.textColor = UIColor.yellow
        }
        
        return cell
    }
    
    func sort (mode: SortMode) {
        switch mode {
        case .byDateAscending:
            if (self.notes.count > 1){
                self.notes = self.notes.sorted(by: {
                    $0.date.compare($1.date) == .orderedAscending
                })
            }
        case .byDateDescending:
            if (self.notes.count > 1){
                self.notes = self.notes.sorted(by: {
                    $0.date.compare($1.date) == .orderedDescending
                })
            }
        }
    }
}

enum SortMode {
    case byDateAscending
    case byDateDescending
}
