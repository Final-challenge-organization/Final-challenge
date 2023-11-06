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
    @State var cardSelected: Card? = nil
    @State var isTapped: Bool = false

    @State var isPresentedGame: Bool
    @State var showAlertWinner: Bool = false
    @State var showAlertLost: Bool = false
    @State private var duoConditionalALert: Bool = false
    @State var killTapped: Bool = false
    @State var isShowingYourTurn: Bool = true

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
                    ZStack {
                        Image("deck_comprar")
                            .offset(x: -250, y: 110)
                        HStack(spacing: -50) {
                            Spacer()
                            ForEach(Array(websocket.myPlayerReference.handCards.enumerated()), id: \.element.uuid) { (index , card) in
                                CardRepresentable(
                                    isYourTurn: websocket.myPlayerReference.isYourTurn,
                                    isReaction: websocket.myPlayerReference.isReaction,
                                    card: card) {
                                        if self.isTapped {
                                            withAnimation {
                                                self.isTapped.toggle()
                                                self.killTapped = false
                                            }
                                        }
                                        self.cardSelected = card
                                        withAnimation {
                                            self.isTapped.toggle()
                                            self.killTapped = false
                                        }
                                    }
                                    .frame(width: 744/7, height: 1039/7)
                                    .scaledToFit()
                                    .offset(y: (index == 0 || index == 2) ? 0 : -15)
                                    .offset(y: cardSelected == card && isTapped ? -80 : 0)
                                    .rotationEffect(Angle(degrees: index == 0 ? -5 : (index == 2 ? 5 : 0)))
                                    .zIndex(index == 2 ? 1 : 0) // Coloca a carta do meio na frente
                            }
                            .transition(.move(edge: .top))
                            Spacer()
                        }
                        .animation(.easeInOut, value: websocket.myPlayerReference.handCards.count)
                        .offset(y: 200)
                        .ignoresSafeArea()

                        if websocket.turnPlayer == "Seu Turno" && isShowingYourTurn {
                            Text("Sua vez!!")
                                .font(.largeTitle)
                                .opacity(1)
                                .animation(.easeInOut(duration: 1))
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation {
                                            isShowingYourTurn = false
                                        }
                                    }
                                }
                        }
                    }
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
        }
        .overlay {
            if isTapped == true {
                ZStack {
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isTapped = false
                            }
                        }
                    CardFocusedView(card: cardSelected!, isTapped: $isTapped)
                        .frame(width: 744/4.5, height: 1039/4.5)
                        .offset(y: -40)
                }
            }
            if websocket.myPlayerReference.isYourTurn {
                Button {
                    websocket.sendCard(with: cardSelected)
                    self.isTapped = false
                    self.killTapped = false
                } label: {
                    Image("button_descarte")
                        .frame(maxWidth: 40, maxHeight: 40)
                        .scaledToFit()
                }
                .offset(x: 250, y: 110)
                .disabled(!isTapped)
            }
            if killTapped == true {
                ZStack {
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .ignoresSafeArea()
                    CardFocusedView(card: websocket.cardsPlayed.last!, isTapped: $killTapped)
                        .frame(width: 744/4.5, height: 1039/4.5)
                        .offset(y: -40)
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
                             index: (players.count < 3) ? 5 : 2,
                             isYourTurn: thirdPlayer.isYourTurn)
                HStack {
                    PersonasView(cards: secondPlayer.handCards,
                                 namePerson: secondPlayer.name,
                                 lifePerson: (secondPlayer.life <= 0) ? 0 : secondPlayer.life,
                                 index: (players.count < 2) ? 5 : 1,
                                 isYourTurn: secondPlayer.isYourTurn)
                    Spacer()

                    PersonasView(cards: lastPlayer.handCards, namePerson: lastPlayer.name,
                                 lifePerson: (lastPlayer.life <= 0) ? 0 : lastPlayer.life,
                                 index: (players.count < 4) ? 5 : 3,
                                 isYourTurn: lastPlayer.isYourTurn)

                }
                .overlay {
                    if (websocket.cardsPlayed.last != nil) {
                        Button {
                            withAnimation {
                                killTapped.toggle()
                                isTapped = false
                            }
                        } label: {
                            KillDeckView(card: websocket.cardsPlayed.last!, killDecktapped: $killTapped)
                                .frame(width: 744/9, height: 1039/9)
                                .opacity(killTapped ? 0 : 1)
                        }
                    }
                }
                PersonasView(cards: firstPlayer.handCards,
                             namePerson: firstPlayer.name,
                             lifePerson: (firstPlayer.life <= 0) ? 0 : firstPlayer.life,
                             index: 0,
                             isYourTurn: firstPlayer.isYourTurn)
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

