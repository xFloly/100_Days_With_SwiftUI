
import SwiftUI

struct GridView: View {
    let astronauts : [String:Astronaut]
    let missions : [Mission]

    let columns=[
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        
        LazyVGrid(columns: columns){
            MissionListView(astronauts: astronauts, missions: missions)
                .preferredColorScheme(.dark)
        }
        .padding([.horizontal,.bottom])
        
    }
    init(astronauts: [String : Astronaut], missions: [Mission]) {
        self.astronauts = astronauts
        self.missions = missions
    }
}

#Preview {
    let astronauts : [String:Astronaut] =  Bundle.main.decode("astronauts.json")
    let missions : [Mission] = Bundle.main.decode("missions.json")

    return GridView(astronauts: astronauts, missions: missions)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
