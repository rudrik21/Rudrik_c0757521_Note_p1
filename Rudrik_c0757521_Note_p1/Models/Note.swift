//
//  Note.swift
//  Rudrik_c0757521_Note_p1
//
//  Created by MacStudent on 2019-11-07.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import Foundation

struct Note : CustomStringConvertible {
    var noteName : String
    static var notes : [Note] = [Note(noteName: "Note 1"), Note(noteName: "Note 2"), Note(noteName: "Note 3"), Note(noteName: "Note 4"), Note(noteName: "Note 5"), Note(noteName: "Note 6"), Note(noteName: "Note 7"), Note(noteName: "Note 8"), Note(noteName: "Note 9"), Note(noteName: "Note 10"), Note(noteName: "Note 11"), Note(noteName: "Note 12"), Note(noteName: "Note 13"), Note(noteName: "Note 14"), Note(noteName: "Note 15"), Note(noteName: "Note 16")]
    
    var description: String{
        return noteName
    }
}
