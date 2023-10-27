//
//  MaybeGameView.swift
//  Mythos
//
//  Created by Luiz Sena on 05/10/23.
//

import SwiftUI
import CoreHaptics

struct MaybeGameView: View {
    @EnvironmentObject var websocket: WebSocket

    @ObservedObject var cardVM = CardViewModel()

//    @State var cardSelected: Card? = nil
//    @State var isTapped: Bool = false
//    @State var killTapped: Bool = false

    @State var isPresentedGame: Bool
    @State var showAlertWinner: Bool = false
    @State var showAlertLost: Bool = false
    @State private var duoConditionalALert: Bool = false

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Image("campo")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Spacer()
                ForEach(Array(websocket.connectedPlayers.enumerated()), id: \.element.id) { index, player in
                    if websocket.myPlayerReference == player {
                            generatePlayerLayout(for: index, players: websocket.connectedPlayers)
                    }
                }
            }
            .overlay {
                VStack {
                    UserCardsView(cardVM: cardVM)
                }
            }
            .onChange(of: websocket.isGameOver) { newValue in
                print("O jogador \(websocket.myPlayerReference.name) perdeu a partida")

                showAlertLost = true
                print("perdeu : \(showAlertLost) ganhou : \(showAlertWinner)")
                isPresentedGame = false

                UserDefaults.standard.set(showAlertLost, forKey: "lost")
                if showAlertLost && !showAlertWinner {
                    duoConditionalALert = true
                }
                UserDefaults.standard.set(isPresentedGame, forKey: "isPresentedGame")
            }
            .onChange(of: websocket.winner) { newValue in
                print("O jogador \(websocket.myPlayerReference.name) venceu a partida")
                showAlertWinner = true
                print("perdeu : \(showAlertLost) ganhou : \(showAlertWinner)")

                UserDefaults.standard.set(showAlertWinner, forKey: "win")
            }
            .alert(isPresented: $duoConditionalALert) {
                Alert(title: Text((showAlertLost && showAlertWinner) ? "Venceu" : "Perdeu"),
                      message: Text((showAlertLost && showAlertWinner) ? "Você venceu a partida!!" : "Você perdeu a partida!!" ),
                      dismissButton: .default(Text("Tela Inicial"), action: {
                    websocket.winner = false
                    dismiss()
                }))
            }
            .onAppear {
                showAlertLost = false
                showAlertWinner = false
            }
        }
        .overlay {
            //MARK: - Mais detalhes cartas da mão
            if cardVM.isTapped == true {
                ZStack {
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                cardVM.isTapped = false
                            }
                        }
                    CardFocusedView(card: cardVM.cardSelected!, isTapped: $cardVM.isTapped)
                        .frame(width: 744/3.5, height: 1039/3.5)
                        .offset(y: -20)
                }
            }
            //MARK: - Botão jogar cartas
            if websocket.myPlayerReference.isYourTurn {
                Button {
                    websocket.sendCard(with: cardVM.cardSelected)
                    self.cardVM.isTapped = false
                    self.cardVM.killTapped = false
                } label: {
                    Image("button_descarte")
                        .frame(maxWidth: 40, maxHeight: 40)
                        .scaledToFit()
                }
                .offset(x: 250, y: 110)
                .disabled(!cardVM.isTapped)
            }
            //MARK: - Clique da Carta Cemitério
            if cardVM.killTapped == true {
                ZStack {
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .ignoresSafeArea()
                    CardFocusedView(card: websocket.cardsPlayed.last!, isTapped: $cardVM.killTapped)
                        .frame(width: 744/3.5, height: 1039/3.5)
                        .offset(x: 130, y:0)
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
                PersonasView(cards: thirdPlayer.handCards,
                             namePerson: thirdPlayer.name,
                             lifePerson: (thirdPlayer.life <= 0) ? 0 : thirdPlayer.life,
                             index: (players.count < 3) ? 5 : 2)

                HStack {
                    PersonasView(cards: secondPlayer.handCards,
                                 namePerson: secondPlayer.name,
                                 lifePerson: (secondPlayer.life <= 0) ? 0 : secondPlayer.life,
                                 index: (players.count < 2) ? 5 : 1)
                    Spacer()

                    PersonasView(cards: lastPlayer.handCards, namePerson: lastPlayer.name,
                                 lifePerson: (lastPlayer.life <= 0) ? 0 : lastPlayer.life,
                                 index: (players.count < 4) ? 5 : 3)

                }
                .overlay {
                    if (websocket.cardsPlayed.last != nil) {
                        Button {
                            withAnimation {
                                cardVM.killTapped.toggle()
                                cardVM.isTapped = false
                            }
                        } label: {
                            KillDeckView(card: websocket.cardsPlayed.last!, killDecktapped: $cardVM.killTapped)
                                .frame(width: 744/9, height: 1039/9)
                                .offset(x: cardVM.killTapped ? 110 : 0, y:0)
                                .opacity(cardVM.killTapped ? 0 : 1)
                        }
                    }
                }
                PersonasView(cards: firstPlayer.handCards,
                             namePerson: firstPlayer.name,
                             lifePerson: (firstPlayer.life <= 0) ? 0 : firstPlayer.life,
                             index: 0)
            }
        }
        return viewPersonas
    }
}

//struct MaybeGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        MaybeGameView(isPresentedGame: true)
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

