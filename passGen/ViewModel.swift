//
//  ViewModel.swift
//  passGen
//
//  Created by Olzhas Zhakan on 08.08.2023.
//

import Foundation

class PassManager {
    var accounts: [Account] = []
    
    func addAcc(login: String, password: String) {
        let newAccount = Account(login: login, password: password)
        accounts.append(newAccount)
    }
}
