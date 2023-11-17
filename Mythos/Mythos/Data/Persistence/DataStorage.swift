//
//  DataStorage.swift
//  Mythos
//
//  Created by Cicero Nascimento on 09/10/23.
//

import Foundation
import UIKit

class DataStorage {
    private var userName: String = ""
    private var userImage: UIImage = UIImage()
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

    func changeUserImage(image: UIImage) {
        userImage = image
    }

    func saveUserImage() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(userImage.pngData()) {
            localStorage.set(encodedData, forKey: "imageKey")
        }
    }

    func getUserName() -> String {
        return userName
    }

    func getUserImageData() -> Data {
        return userImage.jpegData(compressionQuality: 0.01)!
    }

    func getUserImage() -> UIImage {
        loadUserImage()
        return userImage
    }

    func loadUserImage() {
        guard let userDefaultData = localStorage.object(forKey: "imageKey") as? Data else {return}
        if let decodedImage = try?
            JSONDecoder().decode(Data.self, from:
                                    userDefaultData) {
            userImage = UIImage(data: decodedImage)!
        }
    }

    func loadUserName() {
        guard let userDefaultData = localStorage.object(forKey: taskKey) as? Data else {return}
        if let decodedName = try? JSONDecoder().decode(String.self, from: userDefaultData) {
            userName = decodedName
        }
    }
}
