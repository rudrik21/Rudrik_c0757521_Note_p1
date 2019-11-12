//
//  NotesVC.swift
//  Rudrik_c0757521_Note_p1
//
//  Created by Rudrik Panchal on 2019-11-12.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class NotesVC: UIViewController {

    //  MARK: VARIABLES
    var delegate : FoldersVC?
    var currentFolder : Folder?
    
    //  MARK: OUTLETS
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var tvNotes: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
        // Do any additional setup after loading the view.
    }
    
    func start() {
        navBar.title = currentFolder?.folderName
        tvNotes.backgroundColor = #colorLiteral(red: 0.127715386, green: 0.1686877555, blue: 0.2190790727, alpha: 0.9254236356)
        tvNotes.rowHeight = 50
        tvNotes.delegate = self
        tvNotes.dataSource = self
        
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell : NoteCell = sender as? NoteCell {
            if let note : Note = Folder.folders[(currentFolder?.indexOfFolder())!].notes[tvNotes.indexPath(for: cell)!.row] {
                       if let takeNoteVC = segue.destination as? TakeNoteVC {
                           takeNoteVC.delegate = self
                           takeNoteVC.currentNote = note
                       }
                   }
                   
               }
    }
    

}


//  MARK: TABLEVIEW DELEGATE AND DATASOURCE

extension NotesVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (currentFolder?.notes.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as! UITableViewCell
        cell.textLabel!.text = self.currentFolder?.notes[indexPath.row].noteName
        
        return cell
    }
    
    
    
}
