//
//  FriendsList.swift
//  FriendsFavoriteMovies
//
//  Created by Nil Silva on 13/10/2025.
//

import SwiftUI
import SwiftData

struct FriendsList: View {
    
    @Query(sort: \Friend.name) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    @State private var newFriend: Friend?
    
    var body: some View {
        
        NavigationSplitView {
            Group {
                if !friends.isEmpty {
                    List{
                        ForEach(friends){ friend in
                            NavigationLink(friend.name) {
                                FriendDetail(friend: friend)
                            }
                        }
                        .onDelete(perform: deleteFriend)
                    }
                } else {
                    ContentUnavailableView("Add Friends", systemImage: "person.and.person")
                }
            }
            .navigationTitle("Friends")
            .toolbar {
                ToolbarItem() {
                    Button("Add Friend", systemImage: "plus") {
                        addFriend()
                    }
                }
                ToolbarItem {
                    EditButton()
                }

            
            }
            .sheet(item: $newFriend) { friend in
                NavigationStack {
                    FriendDetail(friend: friend, isNew: true)
                }
                .interactiveDismissDisabled(true)
            }
            
        } detail: {
            Text("Select a friend")
                .navigationTitle("Friend")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addFriend() {
        let newFriend = Friend(name: "")
        context.insert(newFriend)
        self.newFriend = newFriend
    }
    
    private func deleteFriend(indexes: IndexSet){
        for index in indexes {
            context.delete(friends[index])
        }
    }
    
}

#Preview {
    FriendsList()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Empty List") {
    FriendsList()
        .modelContainer(for: Friend.self, inMemory: true)
}
