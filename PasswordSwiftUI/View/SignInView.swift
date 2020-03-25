import SwiftUI

struct SignInView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var error = ""
    
    @State private var open = false
    @State private var pulsate = false
    
    @EnvironmentObject private var session: SessionStore
    
    func Spacings() -> CGFloat {
        return (UIScreen.main.bounds.width - 25) / 11
    }
    
    func signIn() {
        session.signInWithMailPass(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack {
                    PlusButton()
                    }
                    .offset(y: -Spacings() * 6.5)
                        
                        VStack(spacing: Spacings() / 2.5) {
                            HStack {
                                Text("Password App")
                                    .font(.title)
                                    .bold()
                                
                                Text("Welcome back, dude")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .offset(y: -Spacings() * -6.5)
                            
                            VStack {
                                VStack {
                                    TextField("Email", text: $email)
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                        .padding(.bottom)
                                    
                                    SecureField("Password", text: $password)
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                }
                                .padding(.horizontal)
                                
                                if (error != "") {
                                    Text(error)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.red)
                                        .offset(y: -Spacings() * -0.3)
                                }
                            }
                            .padding()
                            .offset(y: -Spacings() * -6.5)
                            
                            Spacer()
                            
                            CustomButtonAuthView(action: self.signIn) {
                                Text("Sign In")
                            }
                            .padding()
                            .offset(x: -Spacings() * -5.1, y: -Spacings() * -3.8)
                            .shadow(color: .blue, radius: 180.0).animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.2)).onAppear() {
                                            self.pulsate.toggle()
                            }
                            
                            VStack {
                                NavigationLink(destination: SignUpView()) {
                                        HStack {
                                            Text("Create account")
                                                .font(.system(size: 15, weight: .light))
                                                .foregroundColor(.blue)
                                        }
                                        .padding()
                                        .offset(x: -Spacings() * 3.7, y: -Spacings() * 0.2)
                                }
                            }
                        }
                        .padding(.horizontal, 15)
                    }
            }
        }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().environmentObject(SessionStore())
    }
}
