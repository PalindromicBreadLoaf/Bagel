//
//  RecipeEditView.swift
//  Bagel
//
//  Created by Palindromic Bread Loaf on 7/11/24.
//


import SwiftUI
import CoreData

struct RecipeEditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var recipe: Recipe
    @State private var newIngredient = ""
    
    var body: some View {
        Form {
            Section(header: Text("Recipe Details")) {
                TextField("Title", text: $recipe.title.toUnwrapped(defaultValue: ""))
                TextField("Description", text: $recipe.recipeDescription.toUnwrapped(defaultValue: ""))
            }
            
            Section(header: Text("Ingredients")) {
                HStack {
                    TextField("New Ingredient", text: $newIngredient)
                    Button(action: addIngredient) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
                List {
                    ForEach(recipe.ingredientsArray, id: \.self) { ingredient in
                        Text(ingredient)
                    }
                    .onDelete(perform: deleteIngredient)
                }
            }
            
            Section(header: Text("Instructions")) {
                TextEditor(text: $recipe.instructions.toUnwrapped(defaultValue: ""))
            }
        }
        .navigationTitle("Edit Recipe")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: save) {
                    Text("Save")
                }
            }
        }
    }
    
    private func addIngredient() {
        guard !newIngredient.isEmpty else { return }
        recipe.ingredientsArray.append(newIngredient)
        newIngredient = ""
    }
    
    private func deleteIngredient(at offsets: IndexSet) {
        recipe.ingredientsArray.remove(atOffsets: offsets)
    }
    
    private func save() {
        recipe.ingredients = recipe.ingredientsArray as NSArray
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to save recipe: \(error.localizedDescription)")
        }
    }
}

extension Binding where Value: Equatable {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == T? {
        return Binding<T>(
            get: { self.wrappedValue ?? defaultValue },
            set: { self.wrappedValue = $0 }
        )
    }
}

extension Recipe {
    var ingredientsArray: [String] {
        get { ingredients as? [String] ?? [] }
        set { ingredients = newValue as NSArray }
    }
}
