//
//  RecipeListView.swift
//  Bagel
//
//  Created by Palindromic Bread Loaf on 7/10/24.
//


import SwiftUI
import CoreData

struct RecipeListView: View {
    @FetchRequest(
        entity: Recipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.title, ascending: true)],
        animation: .default)
    private var recipes: FetchedResults<Recipe>
    
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        Text(recipe.title ?? "Untitled")
                    }
                }
                .onDelete(perform: deleteRecipes)
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        addRecipe()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func addRecipe() {
        withAnimation {
            let newRecipe = Recipe(context: viewContext)
            newRecipe.id = UUID()
            newRecipe.title = "New Recipe"
            newRecipe.recipeDescription = ""
            newRecipe.ingredients = [] as NSArray
            newRecipe.instructions = ""
            
            saveContext()
        }
    }
    
    private func deleteRecipes(offsets: IndexSet) {
        withAnimation {
            offsets.map { recipes[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
