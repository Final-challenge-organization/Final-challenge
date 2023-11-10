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
            
            }
        }

    }
}
