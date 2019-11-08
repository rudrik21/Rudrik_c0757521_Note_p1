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
    static var folders : [Folder] = []
    
    var description: String{
        return folderName
    }
}
