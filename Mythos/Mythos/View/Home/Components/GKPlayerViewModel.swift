//
//  GKPlayerViewModel.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 08/11/23.
//

import Foundation
import GameKit

class GKPlayerViewModel: ObservableObject {
    private var localPlayer: GKLocalPlayer = GKLocalPlayer()
    @Published var isAutenticated: Bool = false
    @Published var username: String = "Desconhecido"
    @Published var imagePlayer: UIImage = UIImage()

    private let dataStorage = DataStorage()

    func authentication() {
        if !isAutenticated {
            let localPlayer = GKLocalPlayer.local

            localPlayer.authenticateHandler = { vc, error in
                guard error == nil else {
                    return
                }
                self.localPlayer = localPlayer
                self.isAutenticated = localPlayer.isAuthenticated
                self.username = localPlayer.alias
                self.dataStorage.changeUserName(username: self.username)
                self.dataStorage.saveUserName()
                localPlayer.loadPhoto(for: GKPlayer.PhotoSize.small, withCompletionHandler: { image, error in
                    self.imagePlayer = image ?? UIImage(named: "profile")!
                    self.saveImage(image: self.imagePlayer)
                })
            }
//            self.saveImage(image: self.imagePlayer)
        }
    }

    func saveImage(image: UIImage) {
        dataStorage.changeUserImage(image: image)
        dataStorage.saveUserImage()
        dataStorage.loadUserImage()
    }
//    ws.send(DataWrapper(playerID: UUID(), contentType: .imageToServer, content: image?.pngData() ?? Data()))
}
