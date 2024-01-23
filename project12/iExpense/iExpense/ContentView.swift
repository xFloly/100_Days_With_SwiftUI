
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingAddExpense = false

    @State private var sortOrder = [SortDescriptor(\Expense.amount),
                                    SortDescriptor(\Expense.name)]
    
    @State private var displayType = 0
    @State private var showingFiltered = false
    
    let expensesTypes = ["Business","Personal"]
    
    var body: some View {
        NavigationStack {
            Section{
                ExpenseView(showingFiltered: showingFiltered, displayType: displayType, sortOrder: sortOrder)
                    .navigationTitle("iExpense")
                    .toolbar {
                        Button("Add Expense", systemImage: "plus") {
                            showingAddExpense = true
                        }
                        //challange 2
                        Menu("Sort", systemImage: "arrow.up.arrow.down"){
                            Picker("Sort", selection: $sortOrder){
                                Text("Sort by name")
                                    .tag([SortDescriptor(\Expense.name),
                                          SortDescriptor(\Expense.amount)])
                                Text("Sort by amount")
                                    .tag([SortDescriptor(\Expense.amount),
                                          SortDescriptor(\Expense.name)])
                            }
                        }
                    }
                    .sheet(isPresented: $showingAddExpense) {
                        AddView()
                    }
                //challange 3
                HStack{
                    Button(displayType == 0 ? "Show Personal" : "Show Business"){
                        displayType = displayType == 0 ? 1 : 0
                        if !showingFiltered {
                            showingFiltered.toggle()
                        }
                    }
                    
                    Spacer()
                        .frame(width: 70)
                    
                    Button(showingFiltered ? "Show Both" : "Show Distinct"){
                        showingFiltered.toggle()
                    }
                }
            }

        }
    }
}

#Preview {
    ContentView()
}
