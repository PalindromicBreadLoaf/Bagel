//
//  ItemListView.swift
//  Bagel
//
//  Created by Palindromic Bread Loaf on 7/10/24.
//


import SwiftUI
import CoreData

struct ItemListView: View {
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    Text("\(item.name ?? "Untitled") - \(item.quantity) \(item.unit ?? "")")
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Inventory")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        addItem()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.name = "New Item"
            newItem.quantity = 1
            newItem.unit = "pcs"
            
            saveContext()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
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
