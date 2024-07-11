//
//  RecipeDetailView.swift
//  Bagel
//
//  Created by Palindromic Bread Loaf on 7/10/24.
//

import SwiftUI
import CoreData

struct RecipeDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingEditView = false
    var recipe: FetchedResults<Recipe>.Element

    var body: some View {
        VStack {
            Text(recipe.title ?? "Untitled").font(.largeTitle)
            Text(recipe.recipeDescription ?? "")
            List((recipe.ingredients as? [String]) ?? [], id: \.self) { ingredient in
                Text(ingredient)
            }
            Text(recipe.instructions ?? "")
        }
        .navigationTitle("Recipe Details")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    showingEditView = true
                }) {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $showingEditView) {
            RecipeEditView(recipe: recipe)
        }
    }
    
    private func checkIngredients() {
        // TODO: Check ingredients action
    }
}
