import SwiftUI

struct PlusButton: View {
    
    @State var open = false
    
    var body: some View {
        ZStack {
            Button(action: {self.open.toggle()}) {
                Text("+")
                    .font(.system(size: 90, weight: .bold))
                    .rotationEffect(.degrees(open ? 45 : 0))
                    .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
            }
            
            SecondaryButton(open: $open, title: "Mail", color: .blue, offsetY: -90)
            SecondaryButton(open: $open, title: "Phone", color: .blue, offsetX: -60, offsetY: -60, delay: 0.2)
            SecondaryButton(open: $open, title: "Goggle", color: .blue, offsetX: -90, delay: 0.3)
            SecondaryButton(open: $open, title: "Apple", color: .blue, offsetX: -60, offsetY: 60, delay: 0.4)
        }
    }
}

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton()
    }
}

struct SecondaryButton: View {
    @Binding var open: Bool

    var title: String
    var color: Color
    var offsetX = 0
    var offsetY = 0
    var delay = 0.0

    var body: some View {
        Button(action: {}) {
            Text(title)
                .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
                .scaleEffect(open ? 1 : 0)
                .animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(delay))
        }
    }
}
