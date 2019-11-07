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
    var sections : [String] = ["Folders"]
   
    
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
        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { (act) in
            if let name = alert.textFields?.first?.text{
                if !name.isEmpty{
                    Folder.folders.append(Folder(folderName: name))
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (act) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
        tvFolders.reloadData()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "\t"+sections[section]
        label.font = UIFont(name: "Kailasa", size: 20)
//        label.drawText(in: CGRect(x: 10, y: 10, width: 50, height: 40))
        
        return label
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Folder.folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell") as? FolderCell {
            cell.lblFolderName.text = Folder.folders[indexPath.row].folderName
            
            return cell
        }
        
        return UITableViewCell()
    }
    
//    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomCell") as! CustomCellViewController
//
//        let position: CGPoint = cell.convertPoint(CGPointZero, toView: self.tableView)
//        if let indexPath = self.tableView.indexPathForRowAtPoint(position)
//        {
//            let section = indexPath.section
//            print("will display section: \(section)")
//        }
//    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView{
//            navigationBar.title = sections[0]
//        }else{
//            navigationBar.title = ""
//        }
//    }
    
}
