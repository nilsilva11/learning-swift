//
//  FriendsFavoriteMoviesApp.swift
//  FriendsFavoriteMovies
//
//  Created by Nil Silva on 13/10/2025.
//

import SwiftUI
import SwiftData

@main
struct FriendsFavoriteMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Movie.self, Friend.self])
    }
}
