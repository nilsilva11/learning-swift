//
//  Friend.swift
//  FriendsFavoriteMovies
//
//  Created by Nil Silva on 13/10/2025.
//

import Foundation
import SwiftData

@Model
class Friend {
    
    var name: String
    var favoriteMovie: Movie?
    
    init (name: String){
        self.name = name
    }
    
    static let sampleData = [
        
        Friend(name: "Elena"),
        Friend(name: "Graham"),
        Friend(name: "Mayuri"),
        Friend(name: "Rich"),
        Friend(name: "Rody"),
        
    ]
}
