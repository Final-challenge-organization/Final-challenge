//
//  ClientSideView.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 05/09/23.
//

import SwiftUI
import SpriteKit

struct ClientSideView: View {

    @StateObject var websocket = WebSocket() // ViewModel temporaria
    @State var selectedCard: Card? = nil

    var body: some View {
        
            GameView()
                .environmentObject(websocket)

//            VStack{
//                ScrollView(.horizontal) {
//                    HStack {
//                        ForEach(websocket.cardsPlayed, id: \.self) {
//                            Image($0.name)
//                                .resizable()
//                                .foregroundColor(.black)
//                        }
//                    }
//                }
//                Spacer()
//                Button {
//                    let card = Card(id: 1, name: "Arremesso de Hercules", type: .action, damage: 0)
//                    let toSend = DataWrapper(playerID: websocket.playerID, contentType: .cardToServer, content: card.toData())
//                    websocket.sendData(toSend)
//                    websocket.cardsPlayed.append(card)
//                } label: {
//                    Text("Mande Hello")
//                }.disabled(!websocket.isYourTurn)
//            }


    }
}


struct ClientSideView_Previews: PreviewProvider {
    static var previews: some View {
        ClientSideView()
    }
}
