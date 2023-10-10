//
//  MaybeGameView.swift
//  Mythos
//
//  Created by Luiz Sena on 05/10/23.
//

//
//  MaybeGameView.swift
//  POC-websocketClientSide
//
//  Created by Luiz Sena on 25/09/23.
//

import SwiftUI

struct MaybeGameView: View {
    @ObservedObject var websocket = WebSocket()

    var body: some View {
        VStack {
            HStack {
                Text(websocket.myPlayerReference.name)
                    .padding(.trailing)
                Text(websocket.myPlayerReference.life.description)
            }
            HStack {
                Text(websocket.myPlayerReference.isReaction.description)
                Text(websocket.turnPlayer)
            }
            HStack {
                Text(websocket.cardsPlayed.count.description)
            }
            HStack {
                ForEach(websocket.myPlayerReference.handCards, id: \.id) { card in
                    CardRepresentable(
                        isYourTurn: websocket.myPlayerReference.isYourTurn,
                        isReaction: websocket.myPlayerReference.isReaction,
                        card: card) {
                            websocket.sendCard(with: card)
                        }

                }
                .transition(.move(edge: .top))
            }
            .animation(.easeInOut, value: websocket.myPlayerReference.handCards.count)
        }
        .onAppear {
            websocket.serverConnect()
        }
    }
}

struct MaybeGameView_Previews: PreviewProvider {
    static var previews: some View {
        MaybeGameView()
    }
}

//struct HandCards: View {
//    @Binding var cardHands: [Card]
//
//    var body: some View {
//        ForEach(cardHands, id: \.id) { card in
//            CardRepresentable(invertHeight: true, cardName: card.name) {
//                print(card.name)
//            }
//        }
//    }
//}



