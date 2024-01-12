
import SwiftUI

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
    
    @State private var spinAnimationDegree = [0.0, 0.0, 0.0]
    @State private var fadeAnimationDegree = [0.25,0.25,0.25]
    @State private var allowFade = false

    var defaultOpacity : [Double]{
        [0.25,0.25,0.25]
    }
    
    var defaultSpin : [Double]{
        [0.0, 0.0, 0.0]
    }
    
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
                                .rotation3DEffect(
                                    .degrees(spinAnimationDegree[number]),
                                                        axis: (x: 0.0, y: 1.0, z: 0.0)
                                
                                )
                                .opacity(allowFade ? fadeAnimationDegree[number] : 1.0)
                                //.scaleEffect(spinAnimationDegree[number])
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
        .alert(endTitle, isPresented: $endingGame){
            Button("Restert", action: restart)
        } message: {
            Text("Your final score is \(scoreCount)/\(numberOfGames)")
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreCount)")
        }
    }

    func flagTapped(_ number: Int) {
        //challange 1 & 3- p6
        withAnimation(.easeInOut(duration: 0.7)){
            for x in 0..<3 {
                if x == number{
                    spinAnimationDegree[x] += 360
                }
                else {
                    spinAnimationDegree[x] -= 360
                }
            }
            
        }

        //challange 2 - p6
        fadeAnimationDegree[number] = 1.0
        withAnimation(.default){
            allowFade = true
        }
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            
            withAnimation(.default){
                scoreCount += 1
            }
            
        } else {
            scoreTitle = "Wrong, this is the flag of \(countries[number])"
        }
        
        roundCount += 1
        if roundCount == numberOfGames{
            endingGame = true
        }
        showingScore = true
    }

    func askQuestion() {
        allowFade = false
        spinAnimationDegree = defaultSpin
        fadeAnimationDegree = defaultOpacity
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restart(){
        spinAnimationDegree = defaultSpin
        fadeAnimationDegree = defaultOpacity
        showingScore = false
        roundCount = 0
        scoreCount = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
