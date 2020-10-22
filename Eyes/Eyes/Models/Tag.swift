//
//  Tags.swift
//  Eyes
//
//  Created by Lucas Frazão on 21/10/20.
//

import Foundation
import CloudKitMagicCRUD

class Tag: CKMRecord {

    var recordName: String?
    var displayName_enUS : String
    var displayName_ptBR : String
    
    init(displayName_enUS: String, displayName_ptBR: String) {
        self.displayName_enUS = displayName_enUS
        self.displayName_ptBR = displayName_ptBR
    }
    
}

class MyMovie: CKMRecord {
    
    var recordName: String?
    var movieID: Int? {
        get {
            return Int(recordName ?? "")
        } set {
            recordName = String(newValue ?? 0)
        }
    }
   
    var tags: [Tag]?
    
    init(movieID: Int, tags: Tag...) {
        self.movieID = movieID
        self.tags = tags
    }
    
}
