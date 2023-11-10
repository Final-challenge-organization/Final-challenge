//
//  AutenticatedView.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 07/11/23.
//

import GameKit

class GKPlayerViewModel: ObservableObject {
    @Published var localPlayer: GKLocalPlayer = GKLocalPlayer()
    @Published var isAutenticated: Bool = false

    func authenticateUser() {
        if !isAutenticated {
            let localPlayer = GKLocalPlayer.local


            localPlayer.authenticateHandler = { vc, error in
                guard error == nil else {
                    return
                }
                self.localPlayer = localPlayer
                print(localPlayer.gamePlayerID, localPlayer.alias)
            }
        }
        isAutenticated = GKLocalPlayer.local.isAuthenticated
    }
}
