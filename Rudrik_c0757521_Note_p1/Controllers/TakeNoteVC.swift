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
        navBar.title = String((currentNote?.noteName.prefix(upTo: (currentNote?.noteName.index((currentNote?.noteName.startIndex)!, offsetBy: (currentNote?.noteName.count)!/2))!))!) + "....."
        
        txtNote.text = currentNote?.noteName
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
