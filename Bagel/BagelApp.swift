//
//  BagelApp.swift
//  Bagel
//
//  Created by Palindromic Bread Loaf on 7/10/24.
//

import SwiftUI

@main
struct BagelApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
