//
//  Constants.swift
//  Eyes
//
//  Created by Lucas Frazão on 14/11/20.
//

import UIKit


enum SFSymbols {
    
    static let checkmarkCircle = UIImage(systemName: "checkmark.circle.fill")
    
}

enum MovieDetailError: Error {
    
    case movieCouldNotLoad
    case trailerNotAvailable
    case tmdbPageNotAvailable
    case castingNotAvailable
    case sharingNotAvailable
    
}

enum MovieReviewError: Error {
    
    case reviewIsMissing
    case reviewCouldNotBeSubmitted
    
}




