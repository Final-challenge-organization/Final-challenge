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
        ZStack{
            Image("campo")
                .resizable()
                .ignoresSafeArea()

            VStack {
                PlayerView(playersImage: "sara")
                ZStack{
                    Circle()
                        .foregroundColor(.yellow)
                        .frame(width: 30, height: 30)
                    Text(websocket.myPlayerReference.life.description)
                }
                HStack {

                    PlayerView(playersImage: "luiz")
                        .padding(.leading, 60)

                    ZStack{
                        Circle()
                            .foregroundColor(.yellow)
                            .frame(width: 30, height: 30)
                        Text(websocket.myPlayerReference.life.description)
                    }
                    Spacer()
                    //                Text(websocket.myPlayerReference.name)
                    //                    .padding(.trailing)
                    ZStack{
                        Circle()
                            .foregroundColor(.yellow)
                            .frame(width: 30, height: 30)
                        Text(websocket.myPlayerReference.life.description)
                    }
                    PlayerView(playersImage: "carol")
                        .padding(.trailing, 60)

                }
                HStack {
                    Text(websocket.myPlayerReference.isReaction.description)
                    Text(websocket.myPlayerReference.isYourTurn.description)
                }
                HStack {
                    PlayerView(playersImage: "cicero")
                        .rotationEffect(.degrees(90))
                        .rotationEffect(.degrees(270))
                        .overlay{
                            ZStack{
                                Circle()
                                    .foregroundColor(.yellow)
                                    .frame(width: 30, height: 30)
                                Text(websocket.myPlayerReference.life.description)
                            }.offset(x:25 ,y:20)
                        }

                    Text(websocket.cardsPlayed.count.description)
                }

            }
            VStack{
                Spacer()
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
            
        }
        .ignoresSafeArea()
        .onAppear {
            websocket.serverConnect()
        }
    }
}

struct MaybeGameView_Previews: PreviewProvider {
    static var previews: some View {
        MaybeGameView()
            .previewInterfaceOrientation(.landscapeLeft)
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



