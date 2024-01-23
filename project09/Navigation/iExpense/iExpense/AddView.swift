
import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = "Name"
    @State private var type = "Personal"
    @State private var amount = 0.0
    let currencies = [
        "USD",
        "EUR",
        "GBP",
        "PLN"
    ]
    @State private var curr=Locale.current.currency?.identifier ?? "USD"

    var expenses: Expenses

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
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
            //challange 2
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount,curr: curr)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
                //challange 1
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel") {
                        dismiss()
                    }.foregroundStyle(.red)
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    AddView(expenses: Expenses())
}
