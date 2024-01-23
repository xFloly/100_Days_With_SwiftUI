
import Foundation

struct CrewMember: Hashable{
    let role:String
    let astronaut:Astronaut
    
    init(role: String, astronaut: Astronaut) {
        self.role = role
        self.astronaut = astronaut
    }
}
