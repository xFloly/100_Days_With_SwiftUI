
import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    let currencies = [
        "USD",
        "EUR",
        "GBP",
        "PLN"
    ]
    
    @State private var curr=Locale.current.currency?.identifier ?? "USD"

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                Picker("Currency",selection: $curr){
                    ForEach(currencies, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: curr))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let newExpense = Expense(name: name == "" ? "not defined" : name, type: type, amount: amount, curr: curr)
                    modelContext.insert(newExpense)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView()
}
