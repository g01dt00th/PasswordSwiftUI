import SwiftUI

struct SignInView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var error = ""
    
    @State private var open = false
    @State private var pulsate = false
    
    @EnvironmentObject private var session: SessionStore

    func Spacing() -> CGFloat {
        return (UIScreen.main.bounds.width - 15) / 10
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
                    PlusButtonAuthView()
                    }
                    .contentShape(Rectangle())
                    .offset(y: -Spacing() * 6.5)
                    
                        VStack {
                            HStack {
                                Text("Password App")
                                    .font(.title)
                                    .bold()
                            
                                Text("Welcome back, dude")
                                    .font(.footnote)
                            }
                            .offset(x: -Spacing() * 0, y: -Spacing() * -6.5)
                            
                                VStack {
                                    TextField("Email", text: $email)
                                        .font(.subheadline)
                                        .frame(height: 30)
                                    
                                    SecureField("Password", text: $password)
                                        .font(.subheadline)
                                        .frame(height: 30)
                                }
                                .frame(width: 322)
                                .offset(y: -Spacing() * -7.0)
                                    
                            if (error != "") {
                                    Text(error)
                                        .font(.subheadline)
                                        .background(Color.blue)
                                        .foregroundColor(.red)
                                        .offset(y: -Spacing() * -7.5)
                            }
                            
                            Spacer()
                            
                            HStack {
                                CustomButtonAuthView(action: self.signIn) {
                                    Text("Sign In")
                                }
                                .offset(x: -Spacing() * -5.8, y: -Spacing() * 0.0)
                                .shadow(color: .blue, radius: 180.0).animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.2)).onAppear() {
                                                self.pulsate.toggle()
                                }
                                
                                NavigationLink(destination: SignUpView()) {
                                        HStack {
                                            Text("Create account")
                                                .font(.callout)
                                                .foregroundColor(.blue)
                            }
                        }
                                .offset(x: -Spacing() * 5.4)
                    }
                        .offset(y: -Spacing() * -1.5)
                }
            }
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().environmentObject(SessionStore())
    }
}
