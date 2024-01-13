//import Obseravation
import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let curr: String
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()

    @State private var showingAddExpense = false

    let expensesTypes = ["Business","Personal"]
    
    var body: some View {
        NavigationStack {
            Section{
                List {
                    //challange 3
                    ForEach(expensesTypes ,id: \.self){ type in
                        Section(header:Text(type)){
                            ForEach(expenses.items) { item in
                                if (item.type==type){
                                HStack {
                                    VStack(alignment: .leading) {
                                        //challange 2
                                        if item.amount<10{
                                            Text(item.name)
                                                .font(.caption).italic()
                                        }
                                        else if item.amount<100{
                                            Text(item.name)
                                                .font(.callout)
                                        }
                                        else{
                                            Text(item.name)
                                                .font(.headline).bold()
                                        }
                                        Text(item.type)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(item.amount, format: .currency(code: item.curr))
                                }
                            }
                        }
                        .onDelete(perform: removeItems)}
                    }
                }
                .navigationTitle("iExpense")
                .toolbar {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: expenses)
                }
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
