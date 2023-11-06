//
//  DataStorage.swift
//  Mythos
//
//  Created by Cicero Nascimento on 09/10/23.
//

import Foundation

class DataStorage {
    private var userName: String = ""
    let taskKey = "taskKey"

    let localStorage = UserDefaults()

    func changeUserName(username: String) {
        userName = username
    }

    func saveUserName() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(userName) {
            localStorage.set(encodedData, forKey: taskKey)
        }
    }

    func getUserName() -> String {
        return userName
    }

    func loadUserName() {
        guard let userDefaultData = localStorage.object(forKey: taskKey) as? Data else {return}

        if let decodedName = try? JSONDecoder().decode(String.self, from: userDefaultData) {
            userName = decodedName
        }
    }
}
