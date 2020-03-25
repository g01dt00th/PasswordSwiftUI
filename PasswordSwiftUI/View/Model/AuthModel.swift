import Foundation
import Combine

class AuthModel: ObservableObject {
    
    @Published var email: String = "" {
        didSet {
            emailPublisher.send(self.email)
        }
    }
    private let emailPublisher = CurrentValueSubject<String, Never>("")
    
    @Published var password: String = "" {
        didSet {
            passwordPublisher.send(self.password)
        }
    }
    private let passwordPublisher = CurrentValueSubject<String, Never>("")
    
}
