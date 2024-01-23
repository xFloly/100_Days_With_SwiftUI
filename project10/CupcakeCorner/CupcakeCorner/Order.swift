
import Foundation

class UserAddress: Codable{
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool{
        //challange 1
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
}

@Observable
class Order: Codable{
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
//        case _name = "name"
//        case _city = "city"
//        case _streetAddress = "streetAddress"
//        case _zip = "zip"
        case _userAddress = "userAddress"
    }

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
//    var name = ""
//    var streetAddress = ""
//    var city = ""
//    var zip = ""
    
    var hasValidAddress: Bool{
        return userAddress.hasValidAddress
    }
    var userAddress: UserAddress {
        didSet {
            if let encoded = try? JSONEncoder().encode(userAddress) {
                UserDefaults.standard.set(encoded, forKey: "UserAddress")
            }
        }
    }
    
    var cost: Decimal {
        // 2$
        var cost = Decimal(quantity * 2)
    
        // some types of cakes more
        cost += Decimal(type) / 2
        
        // $1 / extra frosting
        if extraFrosting{
            cost += Decimal(quantity)
        }
        
        // $0.50 / sprinkles
        if addSprinkles{
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    //challange 3
    init() {
        if let address = UserDefaults.standard.data(forKey: "UserAddress") {
            if let decodedItems = try? JSONDecoder().decode(UserAddress.self, from: address) {
                userAddress = decodedItems
                return
            }
        }
       userAddress = UserAddress()
    }
    
}
