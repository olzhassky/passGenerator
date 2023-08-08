import Foundation

class PassManager {
    var accounts: [Account] = []
    
    func addAcc(login: String, password: String) {
        let newAccount = Account(login: login, password: password)
        accounts.append(newAccount)
    }
}
