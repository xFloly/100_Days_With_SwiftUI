
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
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            //challange 3
            .toolbar{
                Button((showingGrid ? "ListView" : "GridView"), systemImage: showingGrid ? "list.bullet" : "square.grid.2x2.fill" ){
                    showingGrid.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
