//
//  FriendDetail.swift
//  FriendsFavoriteMovies
//
//  Created by Nil Silva on 13/10/2025.
//

import SwiftUI
import SwiftData

struct MovieDetail: View {
    
    @Bindable var movie: Movie
    let isNew: Bool
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    init(movie: Movie, isNew: Bool = false) {
        self.movie = movie
        self.isNew = isNew
    }
    
    var sortedFriends: [Friend] {
        movie.favoritedBy.sorted { first, second in
            first.name < second.name
        }
    }
    
    var body: some View {
        
        Form {
            TextField("Movie", text: $movie.title)
                .autocorrectionDisabled(true)
            
            DatePicker("Release Date", selection: $movie.releaseDate, displayedComponents: .date)
            
            if !movie.favoritedBy.isEmpty {
                
                Section("FAVORITED BY"){
                    
                    ForEach(sortedFriends) { friend in
                        Text(friend.name)
                    }
                }
            }
        }
        .navigationTitle(isNew ? "New Movie" : "Movie")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button ("Cancel") {
                        context.delete(movie)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    
    NavigationStack {
        MovieDetail(movie: SampleData.shared.movie)
    }
}

#Preview("New Movie") {
    NavigationStack {
        MovieDetail(movie: SampleData.shared.movie, isNew: true)
    }
}


