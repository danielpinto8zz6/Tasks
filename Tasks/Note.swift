//
//  Note.swift
//  Tasks
//
//  Created by daniel on 26/08/2018.
//  Copyright © 2018 daniel. All rights reserved.
//

import Foundation

enum State {
    case done
    case undone
    case inProgress
}

class Note {
    var title: String
    var content: String
    var date: Date
    var state: State
    
    init () {
        self.title = ""
        self.content = ""
        self.date = Date()
        self.state = .undone
    }
    
    var dateToString : String {
    get {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let myString = formatter.string(from: date)
        let yourDate = formatter.date(from: myString)
        let dateString = formatter.string(from: yourDate!)
        
        return dateString
        }
    }
    
}
