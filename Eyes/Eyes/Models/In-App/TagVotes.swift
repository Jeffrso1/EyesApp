//
//  TagVotes.swift
//  Eyes
//
//  Created by Lucas Frazão on 23/10/20.
//

import Foundation
import CloudKitMagicCRUD

class TagVotes: CKMRecord {
    
    var recordName: String?
    let tag: Tag
    var votes: Int = 0
    
    init(tag: Tag) {
        self.tag = tag
    }
    
}
