
import SwiftUI

struct ContentView: View {
    @State private var showingGrid=true
    let astronauts : [String:Astronaut] =  Bundle.main.decode("astronauts.json")
    let missions : [Mission] = Bundle.main.decode("missions.json")
    
    let columns=[
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack{
            ScrollView{
                Group {
                    if showingGrid {
                        GridView(astronauts: astronauts, missions: missions)
                    } else {
                        ListView(astronauts: astronauts, missions: missions)
                    }
                }
                .navigationTitle("Moonshot")
                
            }
            //.listStyle(.plain)
            //.listRowBackground(Color.darkBackground)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar{
                Button(showingGrid ? "ListView" : "GridView" ){
                    showingGrid.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
