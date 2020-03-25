import SwiftUI

struct SignUpView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State var open = false
    
    @State private var pulsate = false
    
    @EnvironmentObject var session: SessionStore
    
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
    
    func Spacings() -> CGFloat {
        return (UIScreen.main.bounds.width - 25) / 11
    }
    
    var body: some View {
        ZStack {
            ZStack {
                PlusButton()
            }
            .offset(y: -Spacings() * 6.5)
            
            VStack(spacing: Spacings() / 2.5) {
                HStack {
                    Text("Create account")
                        .font(.title)
                        .bold()
                    
                    Text("Same shit, dude")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .offset(y: -Spacings() * -6.5)
                
                VStack {
                    VStack {
                        TextField("Email", text: $email)
                            .font(.system(size: 14))
                            .padding(.bottom)
                        
                        SecureField("Password", text: $password)
                            .font(.system(size: 14))
                    }
                    .padding(.horizontal)
                    
                    if (error != "") {
                        Text(error)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding()
                .offset(y: -Spacings() * -6.5)
                
                Spacer()
                
                CustomButtonAuthView(action: signUp) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                }
                .padding()
                .offset(x: -Spacings() * -5.1, y: -Spacings() * -1.8)
                .shadow(color: .blue, radius: 180.0).animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.2)).onAppear() {
                                self.pulsate.toggle()
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionStore())
    }
}
