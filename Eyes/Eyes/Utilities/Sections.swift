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

let sections : [Sections] = [Sections(sectionName: "Popular", sectionType: .popular), Sections(sectionName: "Now Playing", sectionType: .nowPlaying), Sections(sectionName: "Coming Next", sectionType: .upcoming), Sections(sectionName: "Top Rated", sectionType: .topRated)]

var sectionArray = [Sections]()

//for (key, value) in sections {
//
//    sectionArray.append(Sections(sectionName: key, sectionType: value))
//
//}
