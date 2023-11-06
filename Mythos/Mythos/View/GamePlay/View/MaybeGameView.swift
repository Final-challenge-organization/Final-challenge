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
    @ObservedObject private var cardVM = CardViewModel()

    @Environment(\.dismiss) private var dismiss

    @State var isPresentedGame: Bool
    @State var showAlertWinner: Bool = false
    @State var showAlertLost: Bool = false
    @State private var duoConditionalALert: Bool = false
    

    var body: some View {
        ZStack {
            Image("campo")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Spacer()
                PlayerLayoutView(cardVM: cardVM)
            }
            .overlay {
                VStack {
                    HStack {
                        UserCardsView(cardVM: cardVM)
                    }
                }
            }
            .onChange(of: websocket.isGameOver) { newValue in
                showAlertLost = true
                isPresentedGame = false

                UserDefaults.standard.set(showAlertLost, forKey: "lost")
                if showAlertLost && !showAlertWinner {
                    duoConditionalALert = true
                }
                UserDefaults.standard.set(isPresentedGame, forKey: "isPresentedGame")
            }
            .onChange(of: websocket.winner) { newValue in
                showAlertWinner = true
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
            //MARK: - Mais detalhes cartas da mão
            if cardVM.isTapped == true {
                CardHighlightsView(cardVM: cardVM, offSetValuex: 0, offSetValuey: -20, card: cardVM.cardSelected!)
                    .onTapGesture {
                        withAnimation {
                            cardVM.isTapped = false
                        }
                    }
            }
            //MARK: - Botão jogar cartas
            if websocket.myPlayerReference.isYourTurn {
                SendCardButtonView(cardVM: cardVM)
            }
            //MARK: - Clique da Carta Cemitério
            if cardVM.killTapped == true {
                CardHighlightsView(cardVM: cardVM, offSetValuex: 130, offSetValuey: 0, card: websocket.cardsPlayed.last!)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct MaybeGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        MaybeGameView(isPresentedGame: true)
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}


