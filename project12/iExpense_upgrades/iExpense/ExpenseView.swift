
import SwiftData
import SwiftUI

struct ExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    let expensesTypes = ["Business","Personal"]
    
    var body: some View {
        List {
            ForEach(expensesTypes ,id: \.self){ type in
                Section(header:Text(type)){
                    ForEach(expenses) { item in
                        if (item.type==type){
                        HStack {
                            VStack(alignment: .leading) {
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
    }
    
    init(showingFiltered: Bool,  displayType: Int, sortOrder: [SortDescriptor<Expense>]){
        if showingFiltered{
            _expenses = Query(filter: #Predicate<Expense>{ expense in
                expense.type == expensesTypes[displayType]
            }, sort: sortOrder)
        }
        else{
            _expenses = Query(sort: sortOrder)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets{
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ExpenseView(showingFiltered: false, displayType: 1, sortOrder: [SortDescriptor(\Expense.name)])
        .modelContainer(for: Expense.self)
}
