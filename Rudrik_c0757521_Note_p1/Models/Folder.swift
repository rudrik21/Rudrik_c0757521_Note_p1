//
//  Folder.swift
//  Rudrik_c0757521_Note_p1
//
//  Created by MacStudent on 2019-11-07.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import Foundation

struct Folder : CustomStringConvertible {
    var folderName : String
    var notes : [Note] = []
    
    static var folders : [Folder] = []
    
    var description: String{
        return folderName
    }
    
    func indexOfFolder() -> Int? {
        return Folder.folders.firstIndex { (f) -> Bool in
            self.folderName == f.folderName
        }
    }
    
    func indexOfNote(note: Note) -> Int? {
        return notes.firstIndex { (n) -> Bool in
            note.noteName == n.noteName
        }
    }
    
    mutating func addNote(note : Note) {
        Folder.folders[self.indexOfFolder()!].notes.append(note)
    }
    
    mutating func updateNote(note: Note, index : Int) {
        Folder.folders[self.indexOfFolder()!].notes[index] = note
    }
    
    func moveNote(note: Note, from: Int, to: Int) {
        Folder.folders.remove(at: from)
        Folder.folders[to].addNote(note: note)
    }
    
    mutating func removeNote(index: Int) {
        Folder.folders[self.indexOfFolder()!].notes.remove(at: index)
    }
}
