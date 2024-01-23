
import SwiftUI

struct CrewListView: View {
    
    let crew: [CrewMember]
    
    var body: some View {
        HStack{
            Text("Crew")
                .font(.title.bold())
                .padding(.bottom, 5)
                .padding(.horizontal)
            Spacer()
        }
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )

                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)

                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    init(crew: [CrewMember]) {
        self.crew = crew
    }
}


#Preview {
    let missions: [Mission]=Bundle.main.decode("missions.json")
    let astronauts: [String:Astronaut]=Bundle.main.decode("astronauts.json")

    let crew = missions[0].crew.map{
        member in
        if let astronaut = astronauts[member.name]{
            return CrewMember(role:member.role, astronaut:astronaut)
        }
        else{
            fatalError("Missing \(member.name)")
        }
        
    }

    
    return CrewListView(crew: crew)
        .preferredColorScheme(.dark)
}
