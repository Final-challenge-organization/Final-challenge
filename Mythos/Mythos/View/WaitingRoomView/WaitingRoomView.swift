//
//  WaitingRoomView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 18/09/23.
//

import SwiftUI

struct WaitingRoomView: View {
    @StateObject var websocket: WebSocket = WebSocket()
    @State var isDisabled = false
    @State private var showNewScreen = false
    @State var isReady = false

    @State private var opacity: Double  = 0
    @State private var bool: Bool = true
    
    @State var isPresentedWaiting: Bool


    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Text("Esperando jogadores...")
                        .bold()
                }
                Spacer()
                playersConnected
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        isDisabled = true
                        websocket.serverConnect()
                    }, label: {ButtonConnect()}).disabled(isDisabled)
                    Spacer()
                }
            }
        }
        .background {
            Image("backgroundWaitingRoom")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal,content: {CustomToolbarView()})
        }
        .onChange(of: websocket.isAllPlayersConnecteds) { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isReady.toggle()
                }
            }
        }
        .onDisappear {
            isPresentedWaiting = false

        }
        .onAppear {
            websocket.connectedPlayers = []
            if isPresentedWaiting == UserDefaults.standard.bool(forKey: "isPresentedGame") {
                dismiss()
            }
        }

        .navigationDestination(isPresented: $isReady, destination: {MaybeGameView(isPresentedGame: true).environmentObject(websocket)})
    }

    var playersConnected: some View {
        HStack(spacing: 90) {
            withAnimation(.easeIn){
                ForEach(Array(websocket.connectedPlayers.enumerated()), id: \.element.name) { (index, player) in
                    if index == websocket.connectedPlayers.count - 1 {
                        ConnectedPlayersView(name: player.name)
                            .scaleEffect(bool ? 1 : 0)
                            .transition(.move(edge: .trailing))
                            .onAppear {
                                bool = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                    withAnimation{
                                        if !bool {
                                            bool = true
                                        }
                                    }
                                }
                            }
                    } else {
                        ConnectedPlayersView(name: player.name)
                    }
                }

            }
        }
    }
}

struct WaitingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingRoomView(isPresentedWaiting: true).previewInterfaceOrientation(.landscapeLeft)
    }
}
