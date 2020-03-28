import SwiftUI

struct SignUpView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var error = ""
    
    @State private var open = true
    @State private var pulsate = true
    
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
            
            VStack {
                HStack {
                    Text("Create account")
                        .font(.title)
                        .bold()
                    
                    Text("Same shit, dude")
                        .font(.footnote)
                }
                .offset(x: -Spacing() * 0, y: -Spacing() * -5.5)
                
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
                
                if (error != "") {
                    Text(error)
                        .font(.subheadline)
                        .background(Color.blue)
                        .foregroundColor(.red)
                        .offset(y: -Spacing() * -7.5)
                }
                
                Spacer()
                
                HStack {
                    CustomButtonAuthView(action: self.signUp) {
                        Text("Sign In")
                    }
                    .offset(x: -Spacing() * -4.0, y: -Spacing() * 0.0)
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
