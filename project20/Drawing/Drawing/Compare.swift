
import SwiftUI


struct Compare: View {
    
    var body: some View {
        NavigationStack{
            VStack{
            }
        }
        
        

    }
}

#Preview {
    ContentView()
}


//struct Triangle: Shape{
//    func path(in rect: CGRect) -> Path{
//        var path = Path()
//
//        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
//
//        return path
//    }
//}
//
//struct Flower: Shape{
//    var petalOffset = -50.0
//    var petalWidth = 100.0
//
//    func  path(in rect: CGRect) -> Path{
//        var path = Path()
//
//        for number in stride(from: 0, through: Double.pi * 2, by: Double.pi / 8){
//            let rotation = CGAffineTransform(rotationAngle: number)
//            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2,
//                                                                    y: rect.height / 2))
//            let originalPetal = Path(ellipseIn: CGRect(x:petalOffset,y:0,width: petalWidth,height: rect.width/2))
//
//            let rotatedPetal = originalPetal.applying(rotation)
//
//            path.addPath(rotatedPetal)
//        }
//        return path
//    }
//}

////InsettableShape inherits after Shape
//struct Arc: InsettableShape{
//    let startAngle: Angle
//    let endAngle: Angle
//    let clockwise: Bool
//    var insetAmount = 0.0
//
//
//    func path(in rect: CGRect) -> Path{
//        let rotationAdjustmetn = Angle.degrees(90)
//        let modifiedStart = startAngle-rotationAdjustmetn
//        let modifiedEnd = endAngle-rotationAdjustmetn
//
//        var path = Path()
//
//        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2 - insetAmount, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
//
//        return path
//    }
//
//    func inset(by amount: CGFloat) -> some InsettableShape {
//        var arc = self
//        arc.insetAmount += amount
//        return arc
//    }
//}

//        Arc(startAngle: .degrees(60), endAngle: .degrees(-60), clockwise: false)
//            .strokeBorder(.yellow, lineWidth: 50)
        
        
//        Circle()
//            .strokeBorder(.blue, lineWidth: 40)
            
//        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
//            .stroke(.yellow, lineWidth: 10)
//            .frame(width: 300,height: 300)

        
//        Triangle()
//            .stroke(.red, style: StrokeStyle(lineWidth: 10,lineCap: .round, lineJoin: .round))
//            .frame(width: 300, height: 300)

//        Path { path in
//            path.move(to: CGPoint(x:200,y:100))
//            path.addLine(to: CGPoint(x: 100, y: 300))
//            path.addLine(to: CGPoint(x: 300, y: 300))
//            path.addLine(to: CGPoint(x: 200, y: 100))
//            path.closeSubpath()
//        }
//        .stroke(.blue, style: StrokeStyle(lineWidth: 10,lineCap: .round,lineJoin: .round))
