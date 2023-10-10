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
    @ObservedObject var websocket: WebSocket
    @State var cardSelected: Card? = nil
    @State var isTapped: Bool = false
    
    var body: some View {
        ZStack{
            Image("campo")
                .resizable()
                .ignoresSafeArea()
            ZStack {
                PersonasView(namePerson: websocket.connectedPlayers[0].name.description, lifePerson: websocket.connectedPlayers[0].life.description)
                    .offset(x: UIScreen.main.bounds.width/5, y: UIScreen.main.bounds.height/4) //lado esquerda
//                PersonasView(namePerson: websocket.connectedPlayers[2].name.description, lifePerson: websocket.connectedPlayers[2].life.description)
//                    .offset(x: UIScreen.main.bounds.width/8, y: UIScreen.main.bounds.height/2) //lado direito
//                PersonasView(namePerson: websocket.connectedPlayers[1].name.description, lifePerson: websocket.connectedPlayers[1].life.description)
//                    .offset(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height) // cima
//                PersonasView(namePerson: websocket.myPlayerReference.name.description, lifePerson: websocket.myPlayerReference.life.description)


//                ZStack{
//                    Circle()
//                        .foregroundColor(.yellow)
//                        .frame(width: 30, height: 30)
//                    Text(websocket.myPlayerReference.life.description)
//                    HStack {
//
//                        PlayerView(playersImage: "luiz")
//                            .padding(.leading, 60)
//                        ZStack{
//                            Circle()
//                                .foregroundColor(.yellow)
//                                .frame(width: 30, height: 30)
////                            Text(websocket.myPlayerReference.life.description)
//                        }
//                        Spacer()
////                        Text(websocket.myPlayerReference.name)
////                            .padding(.trailing)
//                        ZStack{
//                            Circle()
//                                .foregroundColor(.yellow)
//                                .frame(width: 30, height: 30)
////                            Text(websocket.myPlayerReference.life.description)
//                        }
//                        PlayerView(playersImage: "carol")
//                            .padding(.trailing, 60)
//                    }
//                }
//                HStack {
//                    Text(websocket.myPlayerReference.name)
//                        .padding(.trailing)
//                    Text(websocket.myPlayerReference.life.description)
//                }
//                HStack {
//                    Text(websocket.myPlayerReference.isReaction.description)
//                    Text(websocket.turnPlayer)
//                }
//                HStack {
//                    Text(websocket.cardsPlayed.count.description)
//                }
                VStack{
                    Spacer()
                    PersonasView(namePerson: "Você", lifePerson: websocket.myPlayerReference.life.description)
                    ZStack {
                        Image("deck_comprar")
                            .offset(x: -250, y: 10)
                        HStack(spacing: -50) {
                            Spacer()
                            ForEach(Array(websocket.myPlayerReference.handCards.enumerated()), id: \.element.id) {
                                (index , card) in
                                CardRepresentable(
                                    isYourTurn: websocket.myPlayerReference.isYourTurn,
                                    isReaction: websocket.myPlayerReference.isReaction,
                                    card: card) {
                                        self.cardSelected = card
                                        withAnimation {
                                            self.isTapped.toggle()
                                        }
                                    }
                                    .frame(maxHeight: 150)
                                    .scaledToFit()
                                    .offset(y: cardSelected == card && isTapped ? -55 : 0)
                                    .rotationEffect(Angle(degrees: index == 0 ? -5 : (index == 2 ? 5 : 0)))
                                        .zIndex(index == 1 ? 1 : 0) // Coloca a carta do meio na frente

                            }

                            Spacer()
                            .transition(.move(edge: .top))

                        }
                        .animation(.easeInOut, value: websocket.myPlayerReference.handCards.count)
                        .offset(y: 90)
                        .ignoresSafeArea()

                        if websocket.myPlayerReference.isYourTurn {
                            Button {
                                websocket.sendCard(with: cardSelected)
                                self.isTapped = false
                            } label: {
                                Image("button_descarte")
                                    .frame(maxWidth: 40, maxHeight: 40)
                                    .scaledToFit()
                            }
                            .offset(x: 250, y: 10)
                            .disabled(!isTapped)
                        }
                    }
                }

            }
        }
        .navigationBarBackButtonHidden(true)
    }

}

struct MaybeGameView_Previews: PreviewProvider {
    static var previews: some View {
        MaybeGameView(websocket: WebSocket())
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



