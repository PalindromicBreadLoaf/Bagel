//
//  ContentView.swift
//  Bagel
//
//  Created by Palindromic Bread Loaf on 7/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RecipeListView()
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }
            ItemListView()
                .tabItem {
                    Label("Inventory", systemImage: "cart")
                }
        }
    }
}

#Preview {
    ContentView()
}
