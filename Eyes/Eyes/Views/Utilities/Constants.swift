//
//  Constants.swift
//  Eyes
//
//  Created by Lucas Frazão on 14/11/20.
//

import UIKit


enum SFSymbols {
    
    static let checkmarkCircle = UIImage(systemName: "checkmark.circle.fill")
    static let cloudKit = UIImage(systemName: "icloud.fill")
    static let heart = UIImage(systemName: "heart")
    static let heartFill = UIImage(systemName: "heart.fill")
    static let ellipsisCircleFill = UIImage(systemName: "ellipsis.circle.fill")
    static let gearshape = UIImage(systemName: "gearshape.fill")
}

enum MovieDetailError: Error {
    
    case movieCouldNotLoad
    case trailerNotAvailable
    case tmdbPageNotAvailable
    case castingNotAvailable
    case sharingNotAvailable
    case gearshape
    
}

enum MovieReviewError: Error {
    
    case reviewIsMissing
    case reviewCouldNotBeSubmitted
    
}


