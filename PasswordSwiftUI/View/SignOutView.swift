import SwiftUI

struct SignOutView: View {
    
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listenFirebaseAuth()
    }
    
    var body: some View {
        Group {
            if (session.session != nil) {
                Text("Welcome back")
                Button(action: session.signOutFirebase) {
                    Text("Sign Out")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .font(.system(size: 15, weight: .bold))
                }
            } else {
                SignInView()
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutView().environmentObject(SessionStore() )
    }
}
