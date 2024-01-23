
import SwiftUI


//challenge 2 - p3
struct FlagImage : View {
    var name : String
    
    var body: some View{
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreCount = 0
    
    @State private var numberOfGames = 3
    @State private var endingGame = false
    @State private var endTitle = "Game Ended"
    @State private var roundCount = 0
    

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.17, green: 0.12, blue: 0.26), location: 0.3),
                .init(color: Color(red: 0.63, green: 0.65, blue: 0.27), location: 0.3)
            ], center: .top, startRadius: 350, endRadius: 450)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(name: countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(scoreCount)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        //challenge 3
        .alert(endTitle, isPresented: $endingGame){
            Button("Restert", action: restart)
        } message: {
            Text("Your final score is \(scoreCount)/\(numberOfGames)")
        }
        //challenge 3
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreCount)")
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            //challenge 1
            scoreTitle = "Correct"
            scoreCount += 1
        } else {
            //challenge 2
            scoreTitle = "Wrong, this is the flag of \(countries[number])"
        }
        //challenge 3
        roundCount += 1
        if roundCount == numberOfGames{
            endingGame = true
            return
        }
        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restart(){
        showingScore = false
        roundCount = 0
        scoreCount = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
