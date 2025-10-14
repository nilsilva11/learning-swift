//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Nil Silva on 10/10/2025.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
