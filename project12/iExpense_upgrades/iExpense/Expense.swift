
import SwiftUI
import SwiftData

@Model
class Expense{
    var name: String
    var type: String
    var amount: Double
    var curr: String
    
    init(name: String, type: String, amount: Double, curr: String) {
        self.name = name
        self.type = type
        self.amount = amount
        self.curr = curr
    }
}
