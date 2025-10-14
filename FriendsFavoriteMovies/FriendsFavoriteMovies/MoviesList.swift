//
//  FriendsList.swift
//  FriendsFavoriteMovies
//
//  Created by Nil Silva on 13/10/2025.
//

import SwiftUI
import SwiftData

struct MoviesList: View {
    
    @Query(sort: \Movie.title) private var movies: [Movie]
    @Environment(\.modelContext) private var context
    @State private var newMovie: Movie?
    
    init(titleFilter: String = "") {
        let predicate = #Predicate<Movie> { movie in
            titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter)
        }
        
        _movies = Query(filter: predicate, sort: \Movie.title)
    }
    
    var body: some View {
        
            
        Group {
            if !movies.isEmpty {
                List {
                    ForEach(movies) { movie in
                        NavigationLink(movie.title) {
                            MovieDetail(movie: movie)
                        }
                    }
                    .onDelete { indexSet in
                        deleteMovies(indexes: indexSet)
                    }
                }
            } else {
                ContentUnavailableView("Add Movies", systemImage: "film.stack")
            }
        }
        .navigationTitle("Movies")
        .toolbar {
            ToolbarItem {
                Button("Add Movie", systemImage: "plus") {
                    addMovie()
                }
            }
            ToolbarItem {
                EditButton()
            }
            
        }
        .sheet(item: $newMovie) { movie in
            NavigationStack {
                MovieDetail(movie: movie, isNew: true)
            }
            .interactiveDismissDisabled(true)
        }
    }
    
    private func addMovie() {
        let newMovie = Movie(title: "", releaseDate: .now)
        context.insert(newMovie)
        self.newMovie = newMovie
    }
    
    private func deleteMovies(indexes: IndexSet) {
        for index in indexes {
            context.delete(movies[index])
        }
    }
}

#Preview {
    NavigationStack {
        MoviesList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}
    

#Preview("Filtered") {
    
    NavigationStack {
        
        MoviesList(titleFilter: "tr")
            .modelContainer(SampleData.shared.modelContainer)
    }
}
