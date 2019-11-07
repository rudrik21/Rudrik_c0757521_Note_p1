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
    static var folders : [Folder] = [Folder(folderName: "Folder 1"), Folder(folderName: "Folder 2"), Folder(folderName: "Folder 3"), Folder(folderName: "Folder 4"), Folder(folderName: "Folder 5"), Folder(folderName: "Folder 6"), Folder(folderName: "Folder 7"), Folder(folderName: "Folder 8"), Folder(folderName: "Folder 9"), Folder(folderName: "Folder 10"), Folder(folderName: "Folder 11"), Folder(folderName: "Folder 12"), Folder(folderName: "Folder 13"), Folder(folderName: "Folder 14")]
    
    var description: String{
        return folderName
    }
}
