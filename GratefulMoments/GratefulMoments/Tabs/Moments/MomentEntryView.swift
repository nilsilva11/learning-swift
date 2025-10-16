//
//  MomentEntryView.swift
//  GratefulMoments
//
//  Created by Nil Silva on 16/10/2025.
//

import SwiftUI
import PhotosUI
import SwiftData

struct MomentEntryView: View {
    
    @State private var title = ""   //var so i can store the textfield value as $title of Moment
    @State private var note = ""    //same but with the note
    @State private var imageData: Data? //same with imageData
    @State private var newImage: PhotosPickerItem?
    @State private var isShowingCancelConfirmation = false //state so it can be changed if needed
    
    @Environment(DataContainer.self) private var dataContainer //environment of db created
    @Environment(\.dismiss) private var dismiss //dismiss view, for example sheet page
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                contentStack
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Grateful For")
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) { // cancel button
                    Button("Cancel", systemImage: "xmark") {
                        if title.isEmpty, note.isEmpty, imageData == nil {
                            dismiss() //if all empty -> auto dismiss
                        } else {
                            isShowingCancelConfirmation = true //if there are data, ask for cancel confirmation
                        }
                    }
                    .confirmationDialog("Discard Moment", isPresented: $isShowingCancelConfirmation) { //to discard moment,
                        Button("Discard Moment", role: .destructive) {
                            dismiss()
                        }
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) { //confirm button
                    Button ("Add", systemImage: "checkmark") {
                        let newMoment = Moment (
                            title: title,
                            note: note,
                            imageData: imageData,
                            timestamp: .now
                        )
                        dataContainer.context.insert(newMoment) //insert moment created to db (only memory)
                        do {
                            try dataContainer.context.save() //fully insert moment in the db (disk)
                            dismiss()
                        } catch {
                            // Don't dismiss
                        }
                    }
                    .disabled(title.isEmpty) //title cant be empty
                }
            }
        }
    }
    
    private var photoPicker: some View { //not that much logic in here
        
        PhotosPicker(selection: $newImage) {
            Group {
                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "photo.badge.plus").opacity(0.3)
                        .font(.largeTitle)
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .background(Color(white: 0.4, opacity: 0.32))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .onChange(of: newImage) {
            guard let newImage else { return }
            Task {
                imageData = try await newImage.loadTransferable(type: Data.self)
            }
        }
    }
    
    var contentStack: some View {
        VStack(alignment: .leading) {
            
            TextField(text: $title) {
                Text("Title")
            }
            .font(.title.bold())
            .padding(.top, 48)
            
            Divider()
            
            TextField(text: $note) {
                Text("Log your small wins")
            }
            .multilineTextAlignment(.leading)
            .lineLimit(5...Int.max)
            
            photoPicker
        }
        .padding()
    }
}


#Preview {
    MomentEntryView()
        .environment(DataContainer()) // inject database
        .modelContainer(DataContainer().modelContainer) //use database
}
