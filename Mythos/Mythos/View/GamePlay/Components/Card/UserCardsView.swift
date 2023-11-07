//
//  UserCardsView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 27/10/23.
//

import SwiftUI

struct UserCardsView: View {
    @EnvironmentObject var websocket: WebSocket

    @ObservedObject var cardVM: CardViewModel

    @State var isShowingYourTurn: Bool = true

    var body: some View {
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
                            if self.cardVM.isTapped {
                                withAnimation {
                                    self.cardVM.isTapped.toggle()
                                    self.cardVM.killTapped = false
                                }
                            }
                            self.cardVM.cardSelected = card
                            withAnimation {
                                self.cardVM.isTapped.toggle()
                                self.cardVM.killTapped = false
                            }
                        }
                        .frame(width: 744/7, height: 1039/7)
                        .scaledToFit()
                        .offset(y: (index == 0 || index == 2) ? 0 : -15)
                        .offset(y: cardVM.cardSelected == card && cardVM.isTapped ? -80 : 0)
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
            } else if websocket.turnPlayer != "Seu Turno" {
               Text("")
                    .font(.largeTitle)
                    .opacity(1)
                    .animation(.easeInOut(duration: 1))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isShowingYourTurn = true
                            }
                        }
                    }
            }
        }
    }
}
//
//struct UserCardsView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCardsView()
//    }
//}
