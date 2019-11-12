//
//  FoldersVC.swift
//  Rudrik_c0757521_Note_p1
//
//  Created by MacStudent on 2019-11-07.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class FoldersVC: UIViewController {

    //  MARK: OUTLETS
    @IBOutlet weak var tvFolders: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    //  MARK: VARIABLES
    var sections : [String] = ["Folders"]
        
    //  MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
    
    //  MARK: INITIALIZATION
    func start() {
        tvFolders.delegate = self
        tvFolders.dataSource = self
        tvFolders.backgroundColor = #colorLiteral(red: 0.127715386, green: 0.1686877555, blue: 0.2190790727, alpha: 0.9254236356)
        tvFolders.rowHeight = 50
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationBar.title = sections[0]
        initFolderCell()
    }
    
    //  MARK: REGISTERING CELL WITH TABLE VIEW
    func initFolderCell() {
//        tvFolders.register(UINib(nibName: "FolderCell", bundle: nil), forCellReuseIdentifier: "FolderCell")
    }
    
    //  MARK: ON CREATE NEW FOLDER
    @IBAction func onAddNewFolder(_ sender: UIBarButtonItem) {
        createNewFolder(title: "New Folder", "Enter a name for this folder.")
    }
    
    //  MARK: WHILE CREATING NEW FOLDER
    func createNewFolder(title : String, _ msg : String? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addTextField { (txt) in
            txt.placeholder = "Name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (act) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (act) in
            if let name = alert.textFields?.first?.text{
                if !name.isEmpty{
                    switch self.navigationBar.title {
                    case self.sections[0]:
                        if (Folder.folders.filter { (f) -> Bool in
                            f.folderName == name
                        }.isEmpty) {
                            Folder.folders.append(Folder(folderName: name))
                        }else{
                            showPopup(vc: self, title: "Name Taken", msg: "Please choose a different name", btnText: "OK")
                        }
                    default:
                        return
                    }
                    
                    self.tvFolders.reloadData()
                }
            }
        }))
        
        alert.actions[0].setValue(#colorLiteral(red: 0.127715386, green: 0.1686877555, blue: 0.2190790727, alpha: 0.9254236356), forKey: "titleTextColor")
        alert.actions[1].setValue(UIColor.black, forKey: "titleTextColor")
        present(alert, animated: true, completion: nil)
    }
    
    //  MARK : ON MOVING TABLE ROWS
    @IBAction func onEditTV(_ sender: UIBarButtonItem) {
        tvFolders.isEditing = (sender.title == "Edit" ? true : false)
        sender.title = ((sender.title == "Edit") ? "Done" : "Edit")
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell : FolderCell = sender as? FolderCell {
            let folder = Folder.folders[tvFolders.indexPath(for: cell)!.row]
                if let notesVC = segue.destination as? NotesVC {
                    notesVC.delegate = self
                    notesVC.currentFolder = folder
                }
        }
    }
    
    func updateTable() {
        tvFolders.reloadData()
    }
}

    //  MARK: - TABLE VIEW DELEGATE & DATASOURCES
extension FoldersVC : UITableViewDelegate, UITableViewDataSource{
    
    //    MARK: Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    /*
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Folder.folders.count
    }
        
    //  MARK: Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell") as? FolderCell {
            let folder : Folder = Folder.folders[indexPath.row]
            
            if indexPath.section == 0{
                cell.tag = indexPath.section
                cell.textLabel?.text = folder.folderName
                cell.detailTextLabel?.text = String(folder.notes.count)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    //  MARK: ON MOVE ROW
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = Folder.folders[sourceIndexPath.row]
        Folder.folders[sourceIndexPath.row] = Folder.folders[destinationIndexPath.row]
        Folder.folders[destinationIndexPath.row] = temp
        tvFolders.reloadData()
    }
    
    //  MARK: ON DELETE ROW
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //  MARK: Swipe to delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (act, v, _) in
            if indexPath.section == 0{
                Folder.folders.remove(at: indexPath.row)
                //   print(Folder.folders)
            }
                        
            tableView.reloadData()
        }
        delete.backgroundColor = #colorLiteral(red: 0.127715386, green: 0.1686877555, blue: 0.2190790727, alpha: 0.9254236356)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    //  MARK: Editing style
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
}
