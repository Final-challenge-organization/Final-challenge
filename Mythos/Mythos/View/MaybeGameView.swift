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
    @State var isPresentedGame: Bool
    @State private var showAlertWinner: Bool = false
    @State private var showAlertLost: Bool = false
    @State private var duoConditionalALert: Bool = false

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack{
            Image("campo")
                .resizable()
                .ignoresSafeArea()
            ZStack {
                ForEach(Array(websocket.connectedPlayers.enumerated()), id: \.element.id) { index, player in
                    if websocket.myPlayerReference == player {
                        generatePlayerLayout(for: index, players: websocket.connectedPlayers)
                    }
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
//                    !isPresentedGame && !websocket.winner ? buttonDismiss : nil
                }
                .onChange(of: websocket.isGameOver) { newValue in
                    print("O jogador \(websocket.myPlayerReference.name) perdeu a partida")
                    isPresentedGame = false
                    showAlertLost = true
                    if showAlertLost && !showAlertWinner {
                        duoConditionalALert = true
                    }
                    UserDefaults.standard.set(isPresentedGame, forKey: "isPresentedGame")
                }
                .onChange(of: websocket.winner) { newValue in
                    print("O jogador \(websocket.myPlayerReference.name) venceu a partida")
                    showAlertWinner = true


                }

            }
            .alert(isPresented: $duoConditionalALert) {
                Alert(title: Text((showAlertLost && showAlertWinner) ? "Venceu" : "Perdeu"),
                      message: Text((showAlertLost && showAlertWinner) ? "Você venceu a partida" : "Você perdeu a partida!!" ),
                      dismissButton: .default(Text("Tela Inicial"), action: {
                    dismiss()
                }))
            }

        }
        .navigationBarBackButtonHidden(true)
    }

    func generatePlayerLayout(for index: Int, players: [PlayerClient]) -> some View {

        let firstPlayerIndex = (index) % players.count
        let secondPlayerIndex = (index + 1) % players.count
        let thirdPlayerIndex = (index + 2) % players.count
        let lastPlayerIndex = (index + 3) % players.count

        var firstPlayer = players[firstPlayerIndex]
        var secondPlayer = players[secondPlayerIndex]
        var thirdPlayer = players[thirdPlayerIndex]
        var lastPlayer = players[lastPlayerIndex]

        var viewPersonas: some View {
            VStack {
                (players.count < 3) ? nil : PersonasView(namePerson: thirdPlayer.name, lifePerson: thirdPlayer.life)
                HStack {
                    (players.count < 2) ? nil : PersonasView(namePerson: secondPlayer.name, lifePerson: secondPlayer.life)
                    Spacer()
                    (players.count < 4) ? nil : PersonasView(namePerson: lastPlayer.name, lifePerson: lastPlayer.life)
                        .padding(.trailing, 60)
                }
                PersonasView(namePerson: firstPlayer.name, lifePerson: firstPlayer.life)
            }
        }
        return viewPersonas
    }

}

struct MaybeGameView_Previews: PreviewProvider {
    static var previews: some View {
        MaybeGameView(websocket: WebSocket(), isPresentedGame: true)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}


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

