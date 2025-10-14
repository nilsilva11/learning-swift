//
//  ContentView.swift
//  Pick-a-pal
//
//  Created by Nil Silva on 03/10/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var names: [String] = []
    @State private var nameToAdd = ""
    @State private var pickedName = ""
    @State private var removeName = false
    
    var body: some View {
        VStack {
            
            VStack{
                Image(systemName: "person.3.sequence.fill")
                    .foregroundStyle(Color(.systemBlue))
                    .symbolRenderingMode(.hierarchical)
                Text("Pick-a-pal")
            }
            .font(Font.largeTitle.bold())
            
            Text(pickedName.isEmpty ? "Pick a name" : pickedName)
                .font(.title2)
                .bold()
                .foregroundStyle(Color(.systemBlue))

            
            List{
                ForEach(names, id: \.description) { name in
                    Text(name)
                }

            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            
            TextField("Add Name", text: $nameToAdd)
            
                .autocorrectionDisabled()
                .onSubmit {
                    if !nameToAdd.isEmpty {
                        
                        names.append(nameToAdd)
                        nameToAdd = ""
                    }
                }
            
            Divider()
            
            Toggle("Remove when picked", isOn: $removeName)

            
            Button ("Pick Random Name"){
                if let randomName = names.randomElement() {
                    pickedName = randomName
                    
                    if removeName {
                        names.removeAll { name in
                            return (name == randomName)
                            
                        }
                    }
                } else {
                    pickedName = ""
                }
            }
            .padding(10)
            .background(Color(.systemBlue).opacity(0.50))
            .foregroundColor(.white)
            .cornerRadius(8)
            
            
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
