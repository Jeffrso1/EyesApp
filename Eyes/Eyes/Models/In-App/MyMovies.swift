//
//  MyMovies.swift
//  Eyes
//
//  Created by Lucas Frazão on 23/10/20.
//

import Foundation
import CloudKitMagicCRUD

class MyMovie: CKMRecord {
    
    var recordName: String?
    var movieID: Int? {
        get {
            return Int(recordName ?? "")
        } set {
            recordName = String(newValue ?? 0)
        }
    }
   
    var tagVotes: [TagVotes] 
    
    init(movieID: Int, tagVotes: [TagVotes]) {
        self.tagVotes = tagVotes
        self.movieID = movieID
    }
    
    
}
