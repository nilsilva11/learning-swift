//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Nil Silva on 03/10/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var scoreboard = Scoreboard()
    @State private var startingPoints = 0
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Score Keeper")
                .font(.largeTitle.bold())
                .padding(.bottom)
            
            SettingsView(doesHighestScoreWin: $scoreboard.doesHighestScoreWin, startingPoints: $startingPoints)
                .disabled(scoreboard.state != .setup)
            
            
            Grid {
                
                GridRow{
                    Text("Player")
                        .gridColumnAlignment(.leading)
                        .font(Font.title2.bold())
                    Text("Score")
                        .font(Font.title2.bold())
                        .opacity(scoreboard.state == .setup ? 0 : 1)
                }
                
                ForEach($scoreboard.players) { $player in
                    
                    GridRow{
                        HStack{
                            if scoreboard.winners.contains(player){
                                Image(systemName: "crown.fill")
                                    .foregroundStyle(Color(.systemYellow))
                            }
                            TextField("Name", text: $player.name)
                                .font(.title3)
                        }
                        
                        
                        
                        Text("\(player.score)")
                        Stepper("\(player.score)", value : $player.score)
                            .font(.title2)
                            .labelsHidden()
                    }
                }
            }
            .padding(.vertical)
            
            .autocorrectionDisabled()
            Button("Add Player", systemImage: "plus"){
                scoreboard.players.append(Player(name: "", score: 0))
                
            }
            .opacity(scoreboard.state == .setup ? 1.0 : 0)
            
            Spacer()
            
            
            
            HStack {
                Spacer()
                
                switch scoreboard.state {
                    
                case .setup:
                    Button("Start Game", systemImage: "play.fill") {
                        
                        scoreboard.state = .playing
                        scoreboard.resetScores(to: startingPoints)
                        
                    }
                    
                case .playing:
                    Button("End Game", systemImage: "stop.fill") {
                        
                        scoreboard.state = .gameOver
                    }
                    
                case .gameOver:
                    Button("Reset Game", systemImage: "arrow.2.circlepath.circle.fill") {
                        
                        scoreboard.state = .setup
                    }
                    
                }
                Spacer()
            }
            .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        .controlSize(.large)
                        .tint(.blue)
            
        }
        
        .padding()
    }
}

#Preview {
    ContentView()
}
