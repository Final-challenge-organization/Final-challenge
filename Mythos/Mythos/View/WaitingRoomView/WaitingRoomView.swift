//
//  WaitingRoomView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 18/09/23.
//

import SwiftUI


struct WaitingRoomView: View {
    @ObservedObject var websocket = WebSocket()
    @State var isDisabled = false
    @State private var showNewScreen = false
    @State var isReady = false

    var body: some View {
        ZStack {

            VStack {
                Spacer()
                HStack {
//                    Spacer()
                    Text("Esperando jogadores...")
                        .bold()
//                    Spacer()
                }
                Spacer()
                HStack(spacing: 90) {
                    ForEach(websocket.connectedPlayers, id: \.name) { player in
                        ConnectedPlayersView(name: player.name)
                            .animation(.easeIn, value: true)
                    }
                }
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        isDisabled = true
                        websocket.serverConnect()
                    }, label: {ButtonConnect()}).disabled(isDisabled)
//                        .padding(.bottom, 240)
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
        .onChange(of: websocket.isAllPlayersConnecteds) { _ in
            isReady.toggle()
        }
        .navigationDestination(isPresented: $isReady, destination: {MaybeGameView(websocket: self.websocket)})
    }

}

struct WaitingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingRoomView().previewInterfaceOrientation(.landscapeLeft)
    }
}
