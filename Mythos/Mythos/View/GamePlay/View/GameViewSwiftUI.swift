//
//  MaybeGameView.swift
//  Mythos
//
//  Created by Luiz Sena on 05/10/23.
//

import SwiftUI
import CoreHaptics

struct GameViewSwiftUI: View {
    @EnvironmentObject var websocket: WebSocket
    @EnvironmentObject var tutorialModel: TutorialModel
    @StateObject private var cardVM = CardViewModel()

    @Environment(\.dismiss) private var dismiss

    // variaveis da game play

    @State var isPresentedGame: Bool
    @State var isPresentTutorial: Bool
    @State var showAlertWinner: Bool = false
    @State var showAlertLost: Bool = false
    @State var duoConditionalALert: Bool = false

    // variaveis da game tutorial
    @State private var isShowingYourCards: Bool = true
    @State private var userBlockTwo: Bool = false
    @State private var userBlockFour: Bool = false
    @State private var defesaTwo: Bool = false
    @State private var attackThree: Bool = false
    @State private var attackFour: Bool = false
    @State private var attackOne: Bool = false
    @State private var showAlertEndTutorial: Bool = false
    @State private var dontPad: Bool = false

    var body: some View {
        ZStack {
            Image("campo")
                .resizable()
                .ignoresSafeArea()
            GeometryReader { proxy in
                CardStackView(card: (isPresentTutorial ? tutorialModel.cardsPlayed : websocket.cardsPlayed).last, tapped: $cardVM.killTapped)
                    .frame(width: 100, height: 140)
                    .background {
                        Image("playCardsBackground")
                            .resizable()
                            .frame(width: 100, height: 140)
                            .scaledToFill()
                    }
                    .position(x: proxy.size.width/2, y: proxy.size.height/2)
                    .onAppear {
                        cardVM.graveyardPosition = CGPoint(x: proxy.size.width/2, y: proxy.size.height/2)
                    }
            }

            isPresentedGame ? UserCardsView(cardVM: cardVM, isGameView: isPresentedGame) : nil
            VStack {
                Spacer()
                isPresentedGame ? PlayerLayoutView(cardVM: cardVM, isGameView: isPresentedGame) : nil
                isPresentTutorial ? PlayerLayoutView(cardVM: cardVM, isGameView: isPresentedGame) : nil
            }
            .onChange(of: isPresentedGame ? websocket.isGameOver : tutorialModel.isGameOver) { newValue in
                showAlertLost = true
                if showAlertLost && !showAlertWinner {
                    duoConditionalALert = true

                }
                UserDefaults.standard.set(false, forKey: "isPresentedGame")
            }
            .onChange(of: isPresentedGame ? websocket.winner : tutorialModel.winner) { newValue in
                showAlertWinner = true
            }
            .overlay {
                isPresentTutorial ? tutorial : nil
            }
        }
        .alert(isPresented: isPresentedGame ? $duoConditionalALert : $showAlertEndTutorial) {
            isPresentedGame ? alertGameView : alertTutorialView
        }
        .overlay {
            //MARK: - Mais detalhes cartas da mão
            if cardVM.isTapped == true {
                CardHighlightsView(cardVM: cardVM, offSetValuex: 0, offSetValuey: -20, card:  cardVM.cardSelected!, showDescription: !isPresentedGame)
                    .onTapGesture {
                        withAnimation {
                            cardVM.isTapped = false
                        }
                    }
            }
            //MARK: - Clique da Carta Cemitério
            if cardVM.killTapped == true {
                CardHighlightsView(cardVM: cardVM, offSetValuex: 130, offSetValuey: 0, card: isPresentedGame ? websocket.cardsPlayed.last!: tutorialModel.cardsPlayed.last!, showDescription: isPresentedGame ? false : true)
            }
        }
        .onChange(of: isPresentTutorial ? tutorialModel.connectedPlayers[0].isYourTurn : false ) { turnOne in
            if !turnOne {
                if tutorialModel.cardsPlayed.last?.type == .action(.damage) && tutorialModel.connectedPlayers[1].handCards.contains(where: { card in
                    card.type == .reaction
                }){
                    tutorialModel.connectedPlayers[1].isReaction = true
                    tutorialModel.matchNumberTutorial = 0

                } else if tutorialModel.cardsPlayed.last?.type == .action(.block) {
                    userBlockTwo = true
                    tutorialModel.isShowingAnimationBlock = true
                    tutorialModel.matchNumberTutorial = 0
                    tutorialModel.connectedPlayers[2].isYourTurn = true
                } else if tutorialModel.cardsPlayed.last?.type == .reaction {
                    tutorialModel.connectedPlayers[1].isYourTurn = true
                }
            }
        }
        .onChange(of: isPresentTutorial ? tutorialModel.connectedPlayers[1].isReaction : false) { reactionTwo in
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
        .onChange(of: isPresentTutorial ? tutorialModel.connectedPlayers[1].isYourTurn : false) { turnTwo in
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
        .onChange(of: isPresentTutorial ? tutorialModel.connectedPlayers[2].isYourTurn : false ) { turnThree in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if turnThree {
                    if tutorialModel.cardsPlayed.last?.type == .action(.damage) {
                        cardVM.cardSelected = tutorialModel.connectedPlayers[2].handCards[2]
                        tutorialModel.sendCard(with: cardVM.cardSelected!)
                        userBlockFour = true
                        tutorialModel.isShowingAnimationBlock = true
                        tutorialModel.connectedPlayers[2].isYourTurn = false
                    } else if tutorialModel.cardsPlayed.last?.type == .action(.block) {
                        cardVM.cardSelected = tutorialModel.connectedPlayers[2].handCards[0]
                        tutorialModel.sendCard(with: cardVM.cardSelected!)
                        attackFour = true
                        tutorialModel.isShowingAnimationBlock = true
                        tutorialModel.connectedPlayers[2].isYourTurn = false
                    }
                } else {
                    if tutorialModel.cardsPlayed.last?.type == .action(.damage) {
                        if tutorialModel.connectedPlayers[3].handCards.contains(where: { card in
                            card.type == .reaction
                        }) {
                            tutorialModel.connectedPlayers[3].isReaction = true

                        } else {
                            tutorialModel.connectedPlayers[3].life = tutorialModel.connectedPlayers[3].life - tutorialModel.cardsPlayed.last!.damage
                            tutorialModel.connectedPlayers[3].isYourTurn = true

                        }
                    } else if tutorialModel.cardsPlayed.last?.type == .action(.block) {
                        tutorialModel.matchNumberTutorial = 2
                        tutorialModel.connectedPlayers[0].isYourTurn = true
                    }
                }
            }
        }
        .onChange(of: isPresentTutorial ? tutorialModel.connectedPlayers[3].isYourTurn : false) { turnFour in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if turnFour {
                    cardVM.cardSelected = tutorialModel.connectedPlayers[3].handCards[2]
                    tutorialModel.sendCard(with: cardVM.cardSelected!)
                    attackOne = true
                    tutorialModel.connectedPlayers[3].isYourTurn = false
                } else  {
                    tutorialModel.connectedPlayers[0].isReaction = true

                }
            }
        }
        .onChange(of: isPresentTutorial ? tutorialModel.connectedPlayers[0].isReaction : false) { reactionOne in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if reactionOne {
                    tutorialModel.matchNumberTutorial = 3
                    if tutorialModel.cardsPlayed.last?.type == .reaction{
                        tutorialModel.connectedPlayers[0].isReaction = false
                    }
                } else {
                    showAlertEndTutorial = true
                }
            }
        }
        .onAppear {
            isPresentTutorial ? (tutorialModel.isShowingAnimationBlock = false) : nil
        }
        .navigationBarBackButtonHidden(true)
    }

    var tutorial: some View {
        ZStack {
            tutorialModel.isShowingAnimationBlock && isShowingYourCards ? introduction : nil
            ZStack {
                UserCardsView(cardVM: cardVM, isGameView: isPresentedGame)
                HStack {
                    tutorialModel.isShowingAnimationBlock && userBlockTwo ? playerSecondBlock : nil
                    tutorialModel.isShowingAnimationBlock && userBlockFour ? playerFourthBlock : nil
                    defesaTwo ? answerPlayerTwo : nil
                    attackThree ? playerThreeAttacked : nil
                    attackFour ? playerFourAttacked : nil
                    attackOne ? playerOneAttacked : nil
                }
                .position(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height/1.5)
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
            Clique nas cartas para mais informações
            """)
            .font(.title)
        }
        .onChange(of: cardVM.isTapped, perform: { newValue in
            if cardVM.isTapped {
                isShowingYourCards = false
                tutorialModel.isShowingAnimationBlock = false
            }
        })
    }
    var playerSecondBlock: some View {
        TutorialDescription(stepDescription: "Jogador 2 \n Bloqueado")
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
        TutorialDescription(stepDescription: "Jogador 4 \n Bloqueado")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        userBlockFour = false
                        tutorialModel.isShowingAnimationBlock = false
                    }
                }
            }
    }
    var playerFourthAttacked: some View {
        TutorialDescription(stepDescription: "Jogador 4 \n Atacado")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        attackFour = false
                        tutorialModel.isShowingAnimationBlock = false
                    }
                }
            }
    }
    var answerPlayerTwo: some View {
        TutorialDescription(stepDescription: "Jogador 2 \n se defendeu!!")
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
        TutorialDescription(stepDescription: "Jogador 3 foi atacado \n mas não tem carta de \n defesa")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        attackThree = false
                        tutorialModel.isShowingAnimationBlock = false
                    }
                }
            }
    }
    var playerFourAttacked: some View {
        TutorialDescription(stepDescription: "Jogador 4 foi atacado \n mas não tem carta de \n defesa")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        attackFour = false
                        tutorialModel.isShowingAnimationBlock = false
                    }
                }
            }
    }
    var playerOneAttacked: some View {
        TutorialDescription(stepDescription: "Você foi atacado \n Se defenda")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        attackOne = false
                        tutorialModel.isShowingAnimationBlock = false
                    }
                }
            }
    }

    var alertGameView: Alert {
        Alert(title: Text((showAlertLost && showAlertWinner) ? "Venceu" : "Perdeu"),
              message: Text((showAlertLost && showAlertWinner) ? "Você venceu a partida!!" : "Você perdeu a partida!!" ),
              dismissButton: .default(Text("Tela Inicial"), action: {
            websocket.winner = false
            dismiss()
        }))
    }
    var alertTutorialView: Alert {
        Alert(title: Text("Fim do tutorial"),
              message: Text("Agora que você já sabe um pouco sobre a mecanica e as cartas, chame seus amigos para jogar"),
              dismissButton: .default(Text("Tela Inicial"), action: {
            tutorialModel.resetTutorialModel()
            dismiss()
        }))
    }
}

//struct MaybeGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        MaybeGameView(isPresentedGame: true)
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}


