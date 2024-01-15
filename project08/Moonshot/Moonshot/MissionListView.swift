//
//  MissionListView.swift
//  Moonshot
//
//  Created by Student1 on 15/01/2024.
//

import SwiftUI

struct MissionListView: View {
    
    let astronauts : [String:Astronaut]
    let missions : [Mission]
    
    var body: some View {
        ForEach(missions){
            mission in
            NavigationLink{
                MissionView(mission: mission, astronauts: astronauts)
            }label: {
                VStack{
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100,height: 100)
                        .padding()
                    VStack{
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(.rect(cornerRadius:10))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground))
            }
        }
    }
    
    init(astronauts: [String : Astronaut], missions: [Mission]) {
        self.astronauts = astronauts
        self.missions = missions
    }
}

#Preview {
    let astronauts : [String:Astronaut] =  Bundle.main.decode("astronauts.json")
    let missions : [Mission] = Bundle.main.decode("missions.json")

    return MissionListView(astronauts: astronauts, missions: missions)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
