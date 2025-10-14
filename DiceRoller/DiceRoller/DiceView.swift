//
//  DiceView.swift
//  DiceRoller
//
//  Created by Nil Silva on 01/10/2025.
//

import SwiftUI

struct DiceView: View {
    
    @State private var pips: Int = 1
    
    var body: some View {
    
        VStack{
            
            Image(systemName: "die.face.\(pips).fill")
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(contentMode: .fit)
                .shadow(color: .black, radius: 40)
                .foregroundStyle(.black, .white)
            
                
            
            Button("Roll"){
                
                withAnimation {
                    pips = Int.random(in: 1...6)
                }
            }
            .buttonStyle(.bordered)
            .foregroundStyle(.tint)
            .frame(maxWidth: 1000)
            
           
            
            .padding()
        }
        .padding()
        
            
    }
}

#Preview {
    DiceView()
}
