//
//  Note.swift
//  Tasks
//
//  Created by daniel on 26/08/2018.
//  Copyright © 2018 daniel. All rights reserved.
//

import Foundation

class Note {
    var title: String
    var content: String
    var date: String
    
    init (title: String, content:String, date:String) {
        self.title = title
        self.content = content
        self.date = date
    }
}
