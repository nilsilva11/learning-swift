//
//  ContentView.swift
//  DiceRoller
//
//  Created by Nil Silva on 01/10/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numDice: Int = 3
    @State private var message: String = ""
    
    var body: some View {
        VStack {
            Text("Dice Roller")
                .font(Font.largeTitle.bold())
                .foregroundStyle(.white)
                .padding(.bottom, 100)
            
            HStack{
                
                ForEach(1...numDice, id: \.description) { _ in
                                    DiceView()
                                }
            }
            
            HStack {
                Button("Remove Dice", systemImage: "minus.circle.fill") {
                    
                    if numDice > 1 {
                        withAnimation{
                            numDice -= 1
                        }
                        message = ""
                        
                    } else{
                        message = "You can't have less than 1 dice"
                    }
                }
                .foregroundStyle(.gray)
                
                            
                Button("Add Dice", systemImage: "plus.circle.fill") {
                    
                    if numDice < 3{
                        withAnimation{
                            numDice += 1
                        }
                        message = ""
                        
                    }else{
                        message = "You can't have more than 3 dice"
                    }
                    
                }
                
        
            }
            .labelStyle(.iconOnly)
            .font(.title)
            .padding(.bottom, 20)
            
            if !message.isEmpty {
                Text(message)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(.red.opacity(0.50))
                    .font(.title3)
                    .cornerRadius(8)
                    .padding(.top, 5)
            }
            
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.pastel)
        .tint(.white)
        
        
    }
}

#Preview {
    ContentView()
}
