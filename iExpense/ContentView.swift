//
//  ContentView.swift
//  iExpense
//
//  Created by Silver on 5/18/22.
// Hi my name is Silver!


import SwiftUI


struct style: ViewModifier {
    var amount: Double
    
    func body(content: Content) -> some View {
        if amount < 10 {
            return content.foregroundColor(.purple)
        } else if amount < 100 {
            return content.foregroundColor(.green)
        } else {
            return content.foregroundColor(.blue)
        }
    }
}




struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.name) {item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                                .modifier(style(amount: item.amount))

                            Text(item.type)
                                .modifier(style(amount: item.amount))

                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .modifier(style(amount: item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
