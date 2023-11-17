//
//  GameTutorial.swift
//  Mythos
//
//  Created by Narely Lima on 07/11/23.
//

import SwiftUI
import Combine

struct GameTutorial: View {

    @EnvironmentObject var tutorialModel: TutorialModel

    @ObservedObject private var cardVM = CardViewModel()

    @State private var isShowingYourCards: Bool = true
    @State private var userBlockTwo: Bool = false
    @State private var userBlockFour: Bool = false
    @State private var defesaTwo: Bool = false
    @State private var attackThree: Bool = false

    @State var stateTutorial: [Int] = []

    var body: some View {
        ZStack {
            Image("campo")
                .resizable()
                .ignoresSafeArea()
            VStack {
                // Criar 4 Jogadores
                Spacer()
                PlayerLayoutTutorial(cardVM: cardVM)
            }
            // Colocar as 3 cartas de cada jogador
            .overlay {
                tutorialModel.isShowingAnimationBlock && isShowingYourCards ? introduction : nil
                ZStack {
                    UserCardsTutorial(cardVM: cardVM)
                    tutorialModel.isShowingAnimationBlock && userBlockTwo ? playerSecondBlock : nil
                    tutorialModel.isShowingAnimationBlock && userBlockFour ? playerFourthBlock : nil
                    defesaTwo ? answerPlayerTwo : nil
                    attackThree ? playerThreeAttacked : nil
                }

            }
        }
        .overlay {
            //MARK: - Mais detalhes cartas da mão
            if cardVM.isTapped == true {
                CardHighlightsView(cardVM: cardVM, offSetValuex: 0, offSetValuey: -20, card: cardVM.cardSelected!, showDescription: true)
                    .onTapGesture {
                        withAnimation {
                            cardVM.isTapped = false
                        }
                    }
            }
            //MARK: - Botão jogar cartas
            if tutorialModel.connectedPlayers[0].isYourTurn {
                SendButtonTutorial(cardVM: cardVM)
            }

            if tutorialModel.connectedPlayers[0].isReaction {
                SendButtonTutorial(cardVM: cardVM)
            }

            //MARK: - Clique da Carta Cemitério
            if cardVM.killTapped == true {
                CardHighlightsView(cardVM: cardVM, offSetValuex: 130, offSetValuey: 0, card: tutorialModel.cardsPlayed.last!, showDescription: false)
            }
        }
        .onChange(of: tutorialModel.connectedPlayers[0].isYourTurn) { turnOne in
            if !turnOne {
                if tutorialModel.cardsPlayed.last?.type == .action(.damage) && tutorialModel.connectedPlayers[1].handCards.contains(where: { card in
                    card.type == .reaction
                }){
                    tutorialModel.connectedPlayers[1].isReaction = true
                    stateTutorial.append(1)
                    UserDefaults.standard.set(stateTutorial, forKey: "Estados")
                } else if tutorialModel.cardsPlayed.last?.type == .action(.block) {
                    userBlockTwo = true
                    tutorialModel.isShowingAnimationBlock = true
                    tutorialModel.connectedPlayers[2].isYourTurn = true

                } else {
                    tutorialModel.connectedPlayers[1].isYourTurn = true
                }
            }
        }
        .onChange(of: tutorialModel.connectedPlayers[1].isReaction) { reactionTwo in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if reactionTwo {
                    cardVM.cardSelected = tutorialModel.connectedPlayers[1].handCards[1]
                    tutorialModel.sendCard(with: cardVM.cardSelected!)
                    defesaTwo = true
                    tutorialModel.connectedPlayers[1].isReaction = false
                } else {
                    tutorialModel.connectedPlayers[1].isYourTurn = true
                }
            }
        }
        .onChange(of: tutorialModel.connectedPlayers[1].isYourTurn) { turnTwo in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if turnTwo {
                    cardVM.cardSelected = tutorialModel.connectedPlayers[1].handCards[2]
                    tutorialModel.sendCard(with: cardVM.cardSelected!)
                    tutorialModel.connectedPlayers[1].isYourTurn = false
                    attackThree = true
                } else {
                    if tutorialModel.connectedPlayers[2].handCards.contains(where: { card in
                        card.type == .reaction
                    }) {
                        tutorialModel.connectedPlayers[2].isReaction = true

                    } else {
                        tutorialModel.connectedPlayers[2].life = tutorialModel.connectedPlayers[2].life - tutorialModel.cardsPlayed.last!.damage
                        tutorialModel.connectedPlayers[2].isYourTurn = true
                    }
                }
            }
        }
        .onChange(of: tutorialModel.connectedPlayers[2].isYourTurn) { turnThree in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if turnThree {
                    cardVM.cardSelected = tutorialModel.connectedPlayers[2].handCards[2]
                    tutorialModel.sendCard(with: cardVM.cardSelected!)
                    userBlockFour = true
                    tutorialModel.isShowingAnimationBlock = true
                    tutorialModel.connectedPlayers[2].isYourTurn = false

                } else {
                    tutorialModel.connectedPlayers[0].isYourTurn = true
                }
            }
        }
    }

    var introduction: some View {
        ZStack {
            RoundedRectangle(cornerSize: .zero)
                .fill(.thinMaterial)
                .ignoresSafeArea()
            Text("""
            Cada jogador recebe 3 cartas
            Clique em cada uma delas para conferir o que cada uma faz
            """)
            .font(.title)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    isShowingYourCards = false
                    tutorialModel.isShowingAnimationBlock = false
                }
            }
        }
    }

    var playerSecondBlock: some View {
        Text("Jogador 2 Bloqueado" )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        userBlockTwo = false
                        tutorialModel.isShowingAnimationBlock = false
                    }
                }
            }

    }
    var playerFourthBlock: some View {
        Text("Jogador 4 Bloqueado" )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        userBlockFour = false
                        tutorialModel.isShowingAnimationBlock = false
                    }
                }
            }
    }
    var answerPlayerTwo: some View {
        Text("O Jogador 2 se defendeu!!")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        defesaTwo = false
                        tutorialModel.isShowingAnimationBlock = false
                    }
                }
            }
    }
    var playerThreeAttacked: some View {
        Text("O Jogador 3 foi atacado, mas não tem carta de defesa")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        attackThree = false
                    }
                }
            }
    }
}
