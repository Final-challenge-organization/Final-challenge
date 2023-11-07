//
//  AutenticatedView.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 07/11/23.
//

import SwiftUI
import GameKit

struct AutenticateView: View {
    @StateObject private var playerViewModel = GKPlayerViewModel()
    @State var isPresented: Bool = false

    var body: some View {
        VStack{
            Text("voce precisa do login")
            Button(action: {playerViewModel.authenticateUser()}, label: {
                Text("Login")
            })
        }
        .navigationDestination(isPresented: $playerViewModel.isAutenticated,
                               destination: {HomeView()})
        .onAppear{
            playerViewModel.authenticateUser()
        }
    }
}

struct AutenticateView_Previews: PreviewProvider {
    static var previews: some View {
        AutenticateView()
    }
}

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
