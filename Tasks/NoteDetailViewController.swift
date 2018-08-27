//
//  NoteDetailViewController.swift
//  Tasks
//
//  Created by daniel on 26/08/2018.
//  Copyright © 2018 daniel. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var contentTextField: UITextView!
    @IBOutlet weak var titleTextField: UITextField!

    var note: Note!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.text = note.title
        contentTextField.text = note.content
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        note.title = titleTextField.text!
        note.content = contentTextField.text
        note.date = datePicker.date as NSDate
    }
}
