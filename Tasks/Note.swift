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

class Note/*: NSObject, NSCoding*/ {
    var title: String?
    var content: String?
    var date: Date
    var state: State
    
     /*override */init () {
        self.title = ""
        self.content = ""
        self.date = Date()
        self.state = .undone
    }
    	
    /*init (title : String, content : String, date : Date, state : State) {
        self.title = title
        self.content = content
        self.date = date
        self.state = state
    }
    
    required convenience init?(coder decode: NSCoder) {
        guard let title = decode.decodeObject(forKey: "title") as? String,
        let content = decode.decodeObject(forKey: "content") as? String,
        let date = decode.decodeObject(forKey: "date") as? Date,
        let state = decode.decodeObject(forKey: "state") as? State
            else { return nil }
        
        self.init (
            title: title,
            content: content,
            date: date,
            state: state
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey:"title")
        aCoder.encode(self.content, forKey:"content")
        aCoder.encode(self.date, forKey:"date")
        aCoder.encode(self.state, forKey:"state")
        
    }*/
    
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
