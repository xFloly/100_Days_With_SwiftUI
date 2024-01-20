
import SwiftUI


struct Triangle: Shape{
    
    func path(in rect: CGRect) -> Path{
        var path = Path()
        
        let width = min(rect.width, rect.height)
        let height = width * 0.75
        let spacing = width * 0.030
        let middle = width * 0.5
        let topWidth = width * 0.226
        let topHeight = height * 0.488
        
        path.addLines([
            CGPoint(x: middle, y: spacing),
            CGPoint(x: middle - topWidth, y: topHeight - spacing),
            CGPoint(x: middle, y: topHeight / 2 + spacing),
            CGPoint(x: middle + topWidth, y: topHeight - spacing),
            CGPoint(x: middle, y: spacing)
        ])
        
        path.move(to: CGPoint(x: middle, y: topHeight / 2 + spacing * 3))
        
        path.addLines([
            CGPoint(x: middle - topWidth/7, y: middle + topHeight/2),
            CGPoint(x: middle - topWidth/7, y: middle - topHeight/2),
            CGPoint(x: middle + topWidth/7, y: middle - topHeight/2),
            CGPoint(x: middle + topWidth/7, y: middle + topHeight/2),
            CGPoint(x: middle - topWidth/7, y: middle + topHeight/2)
            
        ])
        
        //path.stroke(.yellow, style: StrokeStyle(lineWidth: 10,lineCap: .round, lineJoin: .round))
        
        return path
    }
}

struct ContentView: View {
    @State private var lineWidth = 10.0
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            Triangle()
                .stroke(.yellow, style: StrokeStyle(lineWidth: lineWidth,lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300)
                .onTapGesture {
                    withAnimation{
                        lineWidth += lineWidth * 0.2
                        if lineWidth > 100.0{
                            lineWidth = 10.0
                        }
                    }
                }
            
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
