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


let sections : [String : MovieListEndpoint] = ["Popular" : .popular, "Now Playing": .nowPlaying, "Coming Next": .upcoming, "Top Rated": .topRated]

var sectionArray = [Sections]()
