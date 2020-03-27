import SwiftUI

struct PlusButtonAuthView: View {
    @State private var open = false
    
    var body: some View {
        ZStack {
            Button(action: {self.open.toggle()}) {
                Image("PlusButton")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(open ? 45 : 0))
                    .foregroundColor(.primary)
                    .font(.system(size: 70, weight: .bold))
                    .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
            }
        .zIndex(10)
            
            SecondaryButton(open: $open, icon: "Google", color: .blue, offsetY: -90)
            SecondaryButton(open: $open, icon: "Google", color: .red, offsetX: -60, offsetY: -60, delay: 0.2)
            SecondaryButton(open: $open, icon: "Google", color: .green, offsetX: -90, delay: 0.5)
            SecondaryButton(open: $open, icon: "Google", color: .orange, offsetX: -60, offsetY: 60, delay: 0.8)
        }
    }
    
}

struct PlusButtonAuthView_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonAuthView()
    }
}

struct SecondaryButton: View {
    @Binding var open: Bool

    var icon = "Google"
    var color: Color
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0

    var body: some View {
        Button(action: {print("Tap")}) {
                Image(icon)
                    .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
        }
        .padding()
        .background(color)
        .mask(Circle())
        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
        .scaleEffect(open ? 1 : 0)
        .animation(Animation.spring(response: 1, dampingFraction: 1, blendDuration: 1).delay(delay))
    }
}
