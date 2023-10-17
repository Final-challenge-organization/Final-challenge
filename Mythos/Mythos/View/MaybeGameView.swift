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

                }
                VStack{
                    Spacer()
                    ProgressView("Sua Vida:", value: Double(websocket.myPlayerReference.life), total: 30)
                        .progressViewStyle(GaugeProgressStyle())
                        .frame(width: 90, height: 90)


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
                                    .offset(y: (index == 0 || index == 2) ? 0 : -15)
                                    .offset(y: cardSelected == card && isTapped ? -55 : 0)
                                    .rotationEffect(Angle(degrees: index == 0 ? -5 : (index == 2 ? 5 : 0)))
                                    .zIndex(index == 2 ? 1 : 0) // Coloca a carta do meio na frente

                            }
                            .transition(.move(edge: .top))
                            Spacer()
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

                .overlay{
                    ForEach(Array(websocket.connectedPlayers.enumerated()), id: \.element.id) { index, player in
                        if websocket.myPlayerReference == player {
                            generatePlayerLayout(for: index, players: websocket.connectedPlayers)
                        }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    func generatePlayerLayout(for index: Int, players: [PlayerClient]) -> some View {

        let firstPlayerIndex = (index) % players.count
        let secondPlayerIndex = (index + 1) % players.count
        let thirdPlayerIndex = (index + 2) % players.count
        let lastPlayerIndex = (index + 3) % players.count

        let firstPlayer = players[firstPlayerIndex]
        let secondPlayer = players[secondPlayerIndex]
        let thirdPlayer = players[thirdPlayerIndex]
        let lastPlayer = players[lastPlayerIndex]

        var viewPersonas: some View {
            VStack {
                (players.count < 3) ? nil : PersonasView(cards: thirdPlayer.handCards, namePerson: thirdPlayer.name, lifePerson: (thirdPlayer.life <= 0) ? 0 : thirdPlayer.life, index: thirdPlayerIndex)

                HStack {
                    (players.count < 2) ? nil : PersonasView(cards: secondPlayer.handCards, namePerson: secondPlayer.name, lifePerson: (secondPlayer.life <= 0) ? 0 : secondPlayer.life, index: secondPlayerIndex)

                    Spacer()
                    (players.count < 4) ? nil : PersonasView(cards: lastPlayer.handCards, namePerson: lastPlayer.name, lifePerson: (lastPlayer.life <= 0) ? 0 : lastPlayer.life, index: lastPlayerIndex)

                        .offset(y:35)
                }
                PersonasView(cards: firstPlayer.handCards, namePerson: firstPlayer.name, lifePerson: (firstPlayer.life <= 0) ? 0 : firstPlayer.life, index: firstPlayerIndex)

            }
        }
        return viewPersonas
    }

}

//struct MaybeGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        MaybeGameView(websocket: WebSocket())
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}


struct GaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.green.gradient
    var strokeWidth = 8.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        let number = (configuration.fractionCompleted ?? 0) * 30

        return ZStack {
            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .overlay {
                    VStack {
                        Text("Sua vida:")
                            .font(Font.title3.bold())
                            .foregroundColor(.white)
                        Text(Int(number).description)
                            .font(Font.title3.bold())
                            .foregroundColor(.white)
                    }
                }
        }
    }
}

