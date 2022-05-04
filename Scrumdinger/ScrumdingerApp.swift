//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by nexsoft nexsoft on 18/04/22.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    
    //    @State private var scrums = DailyScrum.sampleData
    @StateObject var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums){
                    Task {
                        do {
                            try await ScrumStore.save(scrums: store.scrums)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
                    
                }
            }
            .task {
                do {
                    store.scrums = try await ScrumStore.load()
                } catch {
                    fatalError("Error loading scrums")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                store.scrums = DailyScrum.sampleData                                  
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
            
        }
    }
}
