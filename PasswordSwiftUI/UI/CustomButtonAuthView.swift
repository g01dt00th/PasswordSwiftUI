import SwiftUI

struct CustomButtonAuthView<MyContent: View>: View {
    
    private let action: () -> Void
    private let content: MyContent
    
    @State private var pulsate = false
    
    func Spacing() -> CGFloat {
        return (UIScreen.main.bounds.width - 15) / 10
    }
    
    init(action: @escaping () -> Void, @ViewBuilder content: () -> MyContent) {
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .frame(width: 150, height: 150)
                    .background(Capsule().fill(Color.blue))
                    .scaleEffect(pulsate ? 1 : 1.2)
                    .animation(Animation.easeInOut(duration: 0.5)
                    .repeatForever(autoreverses: true).speed(0.2))
                    .onAppear() { self.pulsate.toggle() }
                content
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                    .font(.callout)
            }
        }
    }
}
