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
   
    var tags: [Tag]
    var tagsSelected: [TagSelected]
    
    init(movieID: Int, tags: [Tag], tagsSelected: [TagSelected]) {
        self.tags = tags
        self.tagsSelected = tagsSelected
        self.movieID = movieID
    }
    
    
}
