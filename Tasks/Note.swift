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
    case finished
}

class Note {
    var title: String
    var content: String
    var date: String
    var state: State
    
    init (title: String, content:String, date:String) {
        self.title = title
        self.content = content
        self.date = date
        self.state = .undone
    }
    
    init () {
        self.title = ""
        self.content = ""
        self.date = ""
        self.state = .undone
    }
    
}
