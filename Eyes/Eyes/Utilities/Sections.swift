//
//  Sections.swift
//  Eyes
//
//  Created by Lucas Frazão on 27/01/21.
//

import Foundation

struct Sections {
    
    var sectionName : String!
    var sectionType : MovieListEndpoint!
    
}

let sections : [Sections] = [Sections(sectionName: NSLocalizedString("Popular", comment: ""), sectionType: .popular), Sections(sectionName: NSLocalizedString("Now Playing", comment: ""), sectionType: .nowPlaying), Sections(sectionName: NSLocalizedString("Upcoming", comment: ""), sectionType: .upcoming), Sections(sectionName: NSLocalizedString("Top Rated", comment: ""), sectionType: .topRated)]

var sectionArray = [Sections]()

//for (key, value) in sections {
//
//    sectionArray.append(Sections(sectionName: key, sectionType: value))
//
//}
