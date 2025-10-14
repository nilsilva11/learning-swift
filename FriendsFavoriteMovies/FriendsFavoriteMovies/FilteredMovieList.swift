//
//  FilteredMovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Nil Silva on 14/10/2025.
//

import SwiftUI
import SwiftData

struct FilteredMovieList: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationSplitView () {
            MoviesList(titleFilter: searchText)
                .searchable(text: $searchText)
        } detail: {
            Text("Select a Movie")
                .navigationTitle("Movie")
                .navigationBarTitleDisplayMode( .inline)
            
        }
            
        
    }
}

#Preview {
    FilteredMovieList()
        .modelContainer(SampleData.shared.modelContainer)
}
