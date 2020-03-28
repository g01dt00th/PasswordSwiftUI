import SwiftUI

struct PlusButtonAuthView: View {
    @State private var open = true
    
    var body: some View {
        ZStack {
            Button(action: {self.open.toggle()}) {
                Image("PlusButton")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(open ? -45 : 45))
                    .foregroundColor(.primary)
                    .font(.system(size: 70, weight: .bold))
                    .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
            }
            .zIndex(10)
            
            Circles(open: $open,
                    color: Color(red: 238 / 255, green: 220 / 255, blue: 147 / 255),
                    offsetX: -120,
                    offsetY: .random(in: -50 ... -30),
                    delay: .random(in: 0 ... 0.3))
            Circles(open: $open,
                    color: Color(red: 208 / 255, green: 171 / 255, blue: 255 / 255),
                    offsetX: -100,
                    offsetY: .random(in: -20 ... -5),
                    delay: .random(in: 0 ... 0.5))
            Circles(open: $open,
                    color: Color(red: 255 / 255, green: 187 / 255, blue: 160 / 255),
                    offsetX: 30,
                    offsetY: .random(in: -10 ... 20),
                    delay: .random(in: 0 ... 0.6))
            Circles(open: $open,
                    color: Color(red: 255 / 255, green: 160 / 255, blue: 160 / 255),
                    offsetX: 50,
                    offsetY: .random(in: 20 ... 50),
                    delay: .random(in: 0 ... 0.7))
            Circles(open: $open,
                    color: Color(red: 147 / 255, green: 194 / 255, blue: 238 / 255),
                    offsetX: -60,
                    offsetY: .random(in: 50 ... 80), delay: .random(in: 0 ... 0.8))
        }
    }
    
}

struct PlusButtonAuthView_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonAuthView()
    }
}

struct Circles: View {
    @Binding var open: Bool
    @State private var pulsate = true
    
    let circleWidth: CGFloat = .random(in: 150 ... 450)
    
    var color: Color
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0
    
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .frame(width: circleWidth, height: circleWidth)
                    .offset(x: open ? CGFloat(offsetX): 0, y: open ? CGFloat(offsetY): 0)
                    .shadow(color: color, radius: 130.0)
            }
            .animation(Animation.easeInOut(duration: 0.5)
            .repeatForever(autoreverses: true).speed(0.1))
            .onAppear() { self.pulsate.toggle() }
        }
        .padding()
        .foregroundColor(color)
        .offset(x: open ? CGFloat(offsetX): 0, y: open ? CGFloat(offsetY): 0)
        .scaleEffect(open ? 1 : 0)
        .animation(Animation.spring(response: 4, dampingFraction: 0.5, blendDuration: 0).delay(delay))
    }
}
