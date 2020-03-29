import SwiftUI

struct SignInView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var error = ""
    
    @State private var open = false
    @State private var pulsate = false
    
    @State private var value: CGFloat = 0
    
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
                .offset(x: -Spacing() * -3.9, y: -Spacing() * 2.9)
                .offset(y: -self.value + 50)
                .animation(.spring())
                
                VStack {
                    HStack {
                        Text("Password App")
                            .font(.title)
                            .bold()
                        
                        Text("Welcome back, dude")
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
                        CustomButtonAuthView(action: self.signIn) {
                            Text("Sign In")
                        }
                        .offset(y: -self.value)
                        .animation(.spring())
                        .offset(x: -Spacing() * -5.7, y: -Spacing() * 0.0)
                        .shadow(color: Color(red: 147 / 255, green: 156 / 255, blue: 238 / 255),
                                radius: 180.0)
                            .animation(Animation.easeInOut(duration: 0.5)
                                .repeatForever(autoreverses: true)
                                .speed(0.2))
                            .onAppear() {
                                self.pulsate.toggle()
                        }
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Create account")
                                .font(.callout)
                                .foregroundColor(Color(red: 255 / 255, green: 160 / 255, blue: 160 / 255))
                        }
                        .offset(y: -self.value)
                        .animation(.spring())
                        .offset(x: -Spacing() * 5.4)
                    }
                    .offset(y: -Spacing() * -1.0)
                    
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
