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
    var shouldEdit = false
    
    //  MARK: OUTLETS
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var tvNotes: UITableView!
    
    @IBOutlet weak var btnAddNote: UIBarButtonItem!
    
    @IBOutlet weak var btnDeleteNote: UIBarButtonItem!
    
    @IBOutlet weak var btnMoveNote: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
    
    func start() {
//        navBar.title = currentFolder?.folderName
        tvNotes.backgroundColor = #colorLiteral(red: 0.127715386, green: 0.1686877555, blue: 0.2190790727, alpha: 0.9254236356)
        tvNotes.rowHeight = 50
        tvNotes.delegate = self
        tvNotes.dataSource = self
        
        btnMoveNote.isEnabled = false
        btnDeleteNote.isEnabled = false
    }

    func updateTable() {
        tvNotes.reloadData()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell : NoteCell = sender as? NoteCell {
            if let takeNoteVC = segue.destination as? TakeNoteVC {
                takeNoteVC.delegate = self
                if let note : Note = currentFolder?.notes[tvNotes.indexPath(for: cell)!.row]{
                        takeNoteVC.currentNote = note
                    }
            }
        }else{
            switch sender as? UIBarButtonItem {
            case btnAddNote:
                if let takeNoteVC = segue.destination as? TakeNoteVC {
                    takeNoteVC.delegate = self
                }
            default:
                return
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.updateTable()
    }
    
    //  MARK: ACTIONS
    
    @IBAction func onEdit(_ sender: UIBarButtonItem) {
        if !shouldEdit{
            shouldEdit = true
            btnMoveNote.isEnabled = true
            btnDeleteNote.isEnabled = true
            
        }else{
            shouldEdit = false
            btnMoveNote.isEnabled = false
            btnDeleteNote.isEnabled = false
            
            tvNotes.visibleCells.forEach { (cell) in
                cell.accessoryType = .detailButton
            }
        }
    }
    
    @IBAction func onDeleteNote(_ sender: UIBarButtonItem) {
        for (i, cell) in tvNotes.visibleCells.enumerated(){
            if cell.accessoryType == UITableViewCell.AccessoryType.checkmark{
                currentFolder?.removeNote(index: i)
            }
        }
        updateTable()
    }
    
    @IBAction func onMoveNote(_ sender: UIBarButtonItem) {
        
    }
}

//  MARK: TABLEVIEW DELEGATE AND DATASOURCE

extension NotesVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Folder.folders[(currentFolder?.indexOfFolder())!].notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? NoteCell
        cell?.textLabel!.text = Folder.folders[(currentFolder?.indexOfFolder())!].notes[indexPath.row].noteName
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? NoteCell
            if cell?.accessoryType == UITableViewCell.AccessoryType.detailButton{
                cell?.accessoryType = .checkmark
            }else{
                cell?.accessoryType = .detailButton
            }
    }
    
}
