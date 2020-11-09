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
    var isSelected: Bool?
    
    init(displayName_enUS: String, displayName_ptBR: String) {
        self.displayName_enUS = displayName_enUS
        self.displayName_ptBR = displayName_ptBR
    }
    
}

class TagSelected: CKMRecord {
    
    var recordName: String?
    var displayName_enUS : String
    var displayName_ptBR : String
    
    init(displayName_enUS: String, displayName_ptBR: String) {
        self.displayName_enUS = displayName_enUS
        self.displayName_ptBR = displayName_ptBR
    }
    
}


enum TagValue: String, CaseIterable, Identifiable {
    
    var id: String { rawValue }
    
    case passInBechdelTest = "BA4EA6EF-56A8-1809-F5C8-915B535EDF59"
    case womanAsMainProtagonist = "DF39ECDB-B0B8-64E3-F26E-8089F682947D"
    case womanIsNotAsMainProtagonist = "5F942B17-37BC-4D7E-2F3A-244F5FB24903"
    case doesntPassInBechdelTest =
        "4C187AE7-DDF2-5F6A-9256-9A55B18BB5F9"
    
}
