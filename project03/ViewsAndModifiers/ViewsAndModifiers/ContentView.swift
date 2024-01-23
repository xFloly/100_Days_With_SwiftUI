
import SwiftUI

//chalange 3
struct LargeTitle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
        
    }
}

extension View {
    func largeTitled() -> some View{
        self.modifier(LargeTitle())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Large Title").largeTitled()
        }
    }
}

#Preview {
    ContentView()
}
