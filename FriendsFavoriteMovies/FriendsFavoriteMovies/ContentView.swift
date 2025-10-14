//
//  ContentView.swift
//  FriendsFavoriteMovies
//
//  Created by Nil Silva on 13/10/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        
        TabView {
            
            Tab("Friends", systemImage: "person.and.person"){
                FriendsList()
            }
            
            Tab("Movies", systemImage: "film.stack"){
                    FilteredMovieList()
            }
            
        }
        
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
