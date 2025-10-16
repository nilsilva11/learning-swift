//
//  DataContainer.swift
//  GratefulMoments
//
//  Created by Nil Silva on 16/10/2025.
//

import SwiftData
import SwiftUI

@Observable //class is being observed by the views who are using @environment, if any of its proporties change, views are going to change as well
@MainActor  //run in mainThread so SwiftUI works

class DataContainer { //creates and generates modelContainer (database)
    
    let modelContainer: ModelContainer  //works as database
    
    var context: ModelContext {     //works as a session of the database, if context.save() doesnt exist, it will never perm save in the db
        modelContainer.mainContext
    }
    
    init(includeSampleMoments: Bool = false) {  //configuring database
        let schema = Schema([   //schema -> list of models that exist inside the db
            Moment.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSampleMoments) //database config -> data base of Moments, storing in the memory as includeSampleMoments is false.

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])  //db creation with config
            
            if includeSampleMoments {
                loadSampleMoments()
            } //if includeSampleMoments -> it will load every single moment from the sampleData
            
            
            
        } catch {
            
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func loadSampleMoments() { //load every moment from sampleData
            for moment in Moment.sampleData {
                context.insert(moment)
            }
        }
}

private let sampleContainer = DataContainer(includeSampleMoments: true) //database with sampleData (for preview purposes)


extension View {
    func sampleDataContainer() -> some View {
        self
            .environment(sampleContainer)
            .modelContainer(sampleContainer.modelContainer)
    }
}
