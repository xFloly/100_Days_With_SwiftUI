
import SwiftUI

struct MissionView: View {

    let mission:Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView{
            VStack{
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal){
                        width, axis in
                        width * 0.6
                    }
                
                Text(mission.formattedLaunchDate)
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.vertical)
                
                VStack(alignment: .leading) {
                    
                    RectangleDividerView()
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom,5)
                    
                    Text(mission.description)
                    
                    RectangleDividerView()
                }
                .padding(.horizontal)
                Group{
                    CrewListView(crew: crew)
                }
            }
            .padding(.bottom)
        }
        .listStyle(.plain)
        .listRowBackground(Color.darkBackground)
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String:Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map{
            member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role:member.role, astronaut:astronaut)
            }
            else{
                fatalError("Missing \(member.name)")
            }
            
        }
    }
}

#Preview {
    let missions: [Mission]=Bundle.main.decode("missions.json")
    let astronauts: [String:Astronaut]=Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0],astronauts: astronauts)
        .preferredColorScheme(.dark)
}
