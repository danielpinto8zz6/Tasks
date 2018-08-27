//
//  Note.swift
//  Tasks
//
//  Created by daniel on 26/08/2018.
//  Copyright © 2018 daniel. All rights reserved.
//

import Foundation

class Note: NSObject, NSCoding {
    var title: String?
    var content: String?
    var date: NSDate?
    var state: String
    
    override init () {
        self.title = ""
        self.content = ""
        self.date = NSDate()
        self.state = "undone"
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.content, forKey: "content")
        aCoder.encode(self.date, forKey: "date")
        aCoder.encode(self.state, forKey: "state")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.title = (aDecoder.decodeObject(forKey: "title") as? String)!
        self.content = (aDecoder.decodeObject(forKey: "title") as? String)!
        self.date = (aDecoder.decodeObject(forKey: "date") as? NSDate)!
        self.state = (aDecoder.decodeObject(forKey: "state") as? String)!
    }
    
    var dateToString : String {
    get {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let myString = formatter.string(from: date as! Date)
        let yourDate = formatter.date(from: myString)
        let dateString = formatter.string(from: yourDate!)
        
        return dateString
        }
    }
    
}
