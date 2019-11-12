//
//  TakeNoteVC.swift
//  Rudrik_c0757521_Note_p1
//
//  Created by Rudrik Panchal on 2019-11-12.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class TakeNoteVC: UIViewController {

    var delegate : NotesVC?
    var currentNote: Note?
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var txtNote: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var navTitle: String?
        if (currentNote?.noteName) != nil{
            navTitle = String((currentNote?.noteName.prefix(upTo: (currentNote?.noteName.index((currentNote?.noteName.startIndex)!, offsetBy: (currentNote?.noteName.count)!/2))!))!) + "....."
        }else{
            navTitle = "New Note"
        }
        navBar.title = navTitle
        
        txtNote.text = currentNote?.noteName
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewDidDisappear(_ animated: Bool) {
        let newNote = Note(noteName: txtNote.text)
        if let currentFolder = delegate?.currentFolder{
            if let note = currentNote{
                if let index = currentFolder.indexOfNote(note: note) {
                    delegate?.currentFolder?.updateNote(note: newNote, index: index)
                }
            }else{
                if !newNote.noteName.isEmpty{
                    delegate?.currentFolder?.addNote(note: newNote)
                }
            }
        }
        
        
        delegate?.updateTable()
    }

}
