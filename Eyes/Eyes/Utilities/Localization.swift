//
//  Localization.swift
//  Eyes
//
//  Created by Lucas Frazão on 14/11/20.
//

import Foundation


enum LanguageCode: String {
    case pt
}


class Language {
    
    
    
    let langCurrentStr = Locale.current.languageCode
    
    func checkCurrentLanguage(from current: String) {
        
        if  langCurrentStr == current   {
            
            
        }
        
    }

}
