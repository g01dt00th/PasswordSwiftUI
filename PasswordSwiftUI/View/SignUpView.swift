import SwiftUI

struct SignUpView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var error = ""
    
    @State private var open = true
    @State private var pulsate = true
    
    @State private var value: CGFloat = 0
    
    @EnvironmentObject private var session: SessionStore
    
    func signUp() {
        session.signUpWithMailPass(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    func Spacing() -> CGFloat {
        return (UIScreen.main.bounds.width - 15) / 10
    }
    
    var body: some View {
        ZStack {
            ZStack {
                PlusButtonAuthView()
            }
            .offset(x: -Spacing() * -3.9, y: -Spacing() * 2.9)
            .offset(y: -self.value + 50)
            .animation(.spring())
            
            VStack {
                HStack {
                    Text("Create account")
                        .font(.title)
                        .bold()
                    
                    Text("Same shit, dude")
                        .font(.footnote)
                }
                .offset(x: -Spacing() * 0, y: -Spacing() * -5.5)
                .offset(y: -self.value + 50)
                .animation(.spring())
                
                VStack {
                    TextField("Email", text: $email)
                        .font(.headline)
                        .frame(height: 30)
                    
                    SecureField("Password", text: $password)
                        .font(.headline)
                        .frame(height: 30)
                }
                .frame(width: 322)
                .offset(y: -Spacing() * -6.0)
                .offset(y: -self.value + 50)
                .animation(.spring())
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                        let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let height = value.height
                        
                        self.value = height
                    }
                    
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                        self.value = 0
                    }
                }
                
                if (error != "") {
                    Text(error)
                        .font(.subheadline)
                        .foregroundColor(Color(red: 255 / 255, green: 160 / 255, blue: 160 / 255))
                        .offset(y: -Spacing() * -7.5)
                        .offset(y: -self.value)
                        .animation(.spring())
                }
                
                Spacer()
                
                HStack {
                    CustomButtonAuthView(action: self.signUp) {
                        Text("Sign Up")
                    }
                    .offset(y: -self.value)
                    .animation(.spring())
                    .offset(x: -Spacing() * -3.9, y: -Spacing() * 0.0)
                    .shadow(color: Color(red: 147 / 255, green: 156 / 255, blue: 238 / 255),
                            radius: 180.0)
                        .animation(Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .speed(0.2))
                        .onAppear() {
                            self.pulsate.toggle()
                    }
                }
                .offset(y: -Spacing() * -1.0)
            }
        }
    }
    
    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView().environmentObject(SessionStore())
        }
    }
}
