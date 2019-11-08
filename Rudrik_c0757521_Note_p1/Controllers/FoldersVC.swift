//
//  FoldersVC.swift
//  Rudrik_c0757521_Note_p1
//
//  Created by MacStudent on 2019-11-07.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class FoldersVC: UIViewController {

    //  MARK : OUTLETS
    @IBOutlet weak var tvFolders: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    //  MARK : VARIABLES
    var sections : [String] = ["Folders", "Notes"]
        
    //  MARK : viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
    
    //  MARK : start()
    func start() {
        tvFolders.delegate = self
        tvFolders.dataSource = self
        initFolderCell()
    }

    func initFolderCell() {
        tvFolders.register(UINib(nibName: "FolderCell", bundle: nil), forCellReuseIdentifier: "FolderCell")
    }
    
    @IBAction func onAddNewFolder(_ sender: UIBarButtonItem) {
        createNewFolder(title: "New Folder", "Enter a name for this folder.")
    }
    
    func createNewFolder(title : String, _ msg : String? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addTextField { (txt) in
            txt.placeholder = "Name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (act) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (act) in
            if let name = alert.textFields?.first?.text{
                if !name.isEmpty{
                    switch self.navigationBar.title {
                    case self.sections[0]:
                        Folder.folders.append(Folder(folderName: name))
                    case self.sections[1]:
                        Note.notes.append(Note(noteName: name))
                    default:
                        return
                    }
                    
                    self.tvFolders.reloadData()
                }
            }
        }))
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func onEditTV(_ sender: UIBarButtonItem) {
        tvFolders.isEditing = (sender.title == "Edit" ? true : false)
        sender.title = ((sender.title == "Edit") ? "Done" : "Edit")
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


extension FoldersVC : UITableViewDelegate, UITableViewDataSource{
    
    //    MARK : Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        navigationBar.title = sections[section]
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0 ? Folder.folders.count : Note.notes.count)
    }
    
        
    //  MARK : Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell") as? FolderCell {
            if indexPath.section == 0{
                cell.lblFolderName.text = Folder.folders[indexPath.row].folderName
            }
            if indexPath.section == 1{
                cell.lblFolderName.text = Note.notes[indexPath.row].noteName
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    //  MARK : ON MOVE ROW
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = Folder.folders[sourceIndexPath.row]
        Folder.folders[sourceIndexPath.row] = Folder.folders[destinationIndexPath.row]
        Folder.folders[destinationIndexPath.row] = temp
        tvFolders.reloadData()
    }
    
    //  MARK : ON DELETE ROW
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //  MARK : Swipe to delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in
            if indexPath.section == 0{
                Folder.folders.remove(at: indexPath.row)
                print(Folder.folders)
            }
            if indexPath.section == 1{
                Note.notes.remove(at: indexPath.row)
                print(Note.notes)
            }
            
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    //  MARK : Editing style
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
}
