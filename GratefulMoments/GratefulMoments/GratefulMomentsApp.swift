//
//  GratefulMomentsApp.swift
//  GratefulMoments
//
//  Created by Nil Silva on 16/10/2025.
//

import SwiftUI
import SwiftData

@main
struct GratefulMomentsApp: App {
    
    let dataContainer = DataContainer()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}
