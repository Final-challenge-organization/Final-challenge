//
//  UserCardsTutorial.swift
//  Mythos
//
//  Created by Narely Lima on 09/11/23.
//

import Foundation
import SwiftUI

struct UserCardsTutorial: View {

    @ObservedObject var cardVM: CardViewModel

    @EnvironmentObject var tutorialModel: TutorialModel

    @State private var isShowingYourTurn: Bool = true

    var body: some View {
        ZStack {
            Image("deck_comprar")
                .offset(x: -250, y: 110)
            HStack(spacing: -50) {
                Spacer()
                ForEach(Array(playersMock[0].handCards.enumerated()), id: \.element.uuid) { (index , card) in
                    CardRepresentable(
                        isYourTurn: playersMock[0].isYourTurn,
                        isReaction: playersMock[0].isReaction,
                        card: card) {
                            if self.cardVM.isTapped {
                                withAnimation {
                                    self.cardVM.isTapped.toggle()
                                    self.cardVM.killTapped = false
                                }
                            }
                            self.cardVM.cardSelected = card
                            self.cardVM.description = card.descTutorial

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
            .animation(.easeInOut, value: playersMock[0].handCards.count)
            .offset(y: 200)
            .ignoresSafeArea()

            if tutorialModel.turnPlayer == "Seu Turno" && isShowingYourTurn {
                Text("Sua vez!!")
                    .font(.largeTitle)
                    .opacity(1)
                    .animation(.easeInOut(duration: 1))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                isShowingYourTurn = false
                            }
                        }
                    }
                    .onDisappear {
                        tutorialModel.isShowingAnimationBlock = true
                    }
            } else if tutorialModel.turnPlayer != "Seu Turno" && !tutorialModel.isShowingAnimationBlock {
                Text("\(tutorialModel.turnPlayer)")
                    .font(.largeTitle)
                    .opacity(1)
                    .animation(.easeInOut(duration: 1))
                    .onDisappear {
                        isShowingYourTurn = true
                        tutorialModel.isShowingAnimationBlock = true
                    }
            }
        }
    }
}
