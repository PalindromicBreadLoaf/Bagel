//
//  RecipeDetailView.swift
//  Bagel
//
//  Created by Palindromic Bread Loaf on 7/10/24.
//

import SwiftUI
import CoreData

struct RecipeDetailView: View {
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
                    checkIngredients()
                }) {
                    Text("Check Ingredients")
                }
            }
        }
    }
    
    private func checkIngredients() {
        // TODO: Check ingredients action
    }
}

