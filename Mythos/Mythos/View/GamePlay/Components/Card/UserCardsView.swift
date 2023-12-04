//
//  UserCardsView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 27/10/23.
//

import SwiftUI

struct UserCardsView: View {
    @EnvironmentObject var websocket: WebSocket
    @EnvironmentObject var tutorialModel: TutorialModel

    @ObservedObject var cardVM: CardViewModel

    @State var isShowingYourTurn: Bool = true
    @State var isGameView: Bool
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(Array((isGameView ? websocket.myPlayerReference : playersMock[0]).handCards.enumerated()), id: \.element.uuid) { (index , card) in
                    CardRepresentable(isYourTurn: (isGameView ? websocket.myPlayerReference : playersMock[0]).isYourTurn, isReaction: (isGameView ? websocket.myPlayerReference : playersMock[0]).isReaction, card: card, isPresentedTutorial: !isGameView) {
                        cardVM.cardSelected = card
                        cardVM.description = card.description
                        withAnimation {
                            cardVM.isTapped = true
                        }
                    }
                    .frame(width: 744/7, height: 1039/7)
                    .position(cardVM.cardLocationForIndex(index: index))
                    .offset(y: cardVM.cardSelected == card && cardVM.isTapped ? -80 : 0)
                    .offset((index == 0 && !cardVM.isDragging) ? CGSize(width: -80, height: 0) : CGSize(width: 0, height: 0))
                    .offset((index == 2 && !cardVM.isDragging) ? CGSize(width: 80, height: 0) : CGSize(width: 0, height: 0))
                    .rotationEffect((index == 0 && !cardVM.isDragging) ? .degrees(-5) : .degrees(0))
                    .rotationEffect((index == 2 && !cardVM.isDragging) ? .degrees(5) : .degrees(0))
                    .zIndex(index == 1 ? 1 : 0)
                    .gesture(
                        DragGesture()
                            .onChanged({ changedValue in
                                withAnimation {
                                    if isGameView {
                                        if cardVM.isAbleToDrag(card: card, isYourTurn: websocket.myPlayerReference.isYourTurn, isReaction: websocket.myPlayerReference.isReaction) {
                                            cardVM.cardLocations[index] = changedValue.location
                                            cardVM.isDragging = true
                                        }
                                    } else {
                                        if tutorialModel.matchNumberTutorial == 1 && playersMock[0].isYourTurn && card.type == .action(.damage) {
                                            cardVM.cardLocations[index] = changedValue.location
                                            cardVM.isDragging = true
                                        } else if tutorialModel.matchNumberTutorial == 2 && playersMock[0].isYourTurn && card.type == .action(.block) {
                                            cardVM.cardLocations[index] = changedValue.location
                                            cardVM.isDragging = true
                                        } else if tutorialModel.matchNumberTutorial == 3 && playersMock[0].isYourTurn && card.type == .reaction {
                                            cardVM.cardLocations[index] = changedValue.location
                                            cardVM.isDragging = true
                                        }
                                    }
                                }
                            })
                            .onEnded({ endedValue in
                                withAnimation {
                                    if isGameView {
                                        if cardVM.isAbleToDrag(card: card, isYourTurn: (isGameView ? websocket.myPlayerReference : playersMock[0]).isYourTurn, isReaction: (isGameView ? websocket.myPlayerReference: playersMock[0]).isReaction) {
                                            cardVM.cardLocations[index] = cardVM.baseCardLocation
                                            cardVM.isDragging.toggle()
                                            cardVM.sendCard = { websocket.sendCard(with: card) }
                                            cardVM.colision(currentLocation: endedValue.location)
                                        }
                                    } else {
                                        if tutorialModel.matchNumberTutorial == 1 && playersMock[0].isYourTurn && card.type == .action(.damage) {
                                            cardVM.cardLocations[index] = cardVM.baseCardLocation
                                            cardVM.isDragging.toggle()
                                            cardVM.sendCard = { tutorialModel.sendCard(with: card) }
                                            cardVM.colision(currentLocation: endedValue.location)
                                        } else if tutorialModel.matchNumberTutorial == 2 && playersMock[0].isYourTurn && card.type == .action(.block) {
                                            cardVM.cardLocations[index] = cardVM.baseCardLocation
                                            cardVM.isDragging.toggle()
                                            cardVM.sendCard = { tutorialModel.sendCard(with: card) }
                                            cardVM.colision(currentLocation: endedValue.location)
                                        } else if tutorialModel.matchNumberTutorial == 3 && playersMock[0].isYourTurn && card.type == .reaction {
                                            cardVM.cardLocations[index] = cardVM.baseCardLocation
                                            cardVM.isDragging.toggle()
                                            cardVM.sendCard = { tutorialModel.sendCard(with: card) }
                                            cardVM.colision(currentLocation: endedValue.location)
                                        }
                                    }

                                }
                            })
                    )
                }
                .transition(.move(edge: .top))
                if isGameView {
                    if websocket.turnPlayer == "Seu Turno" && isShowingYourTurn {
                        TurnIndicatorView(turnDesc: "Sua vez!!", showName: true)
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
                } else {
                    if tutorialModel.turnPlayer == "Seu Turno" && isShowingYourTurn {
                        TurnIndicatorView(turnDesc: "Sua vez!!", showName: true)
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
                        if tutorialModel.turnPlayer == "" {
                            TurnIndicatorView(turnDesc: "\(tutorialModel.turnPlayer)", showName: false)
                        } else {
                            TurnIndicatorView(turnDesc: "\(tutorialModel.turnPlayer)", showName: true)
                                .onDisappear {
                                    isShowingYourTurn = true
                                    tutorialModel.isShowingAnimationBlock = true
                                }
                        }
                    }
                }
            }
            .animation(.easeInOut, value: (isGameView ? websocket.myPlayerReference : playersMock[0]).handCards.count)
            .onAppear {
                cardVM.baseCardLocation = CGPoint(x: proxy.size.width/2, y: proxy.size.height/1.25)
                for i in 0...(cardVM.cardLocations.count-1) {
                    cardVM.cardLocations[i] = CGPoint(x: proxy.size.width/2, y: proxy.size.height/1.25)
                }
            }
            .onChange(of: proxy.size) { newValue in
                cardVM.baseCardLocation = CGPoint(x: newValue.width/2, y: newValue.height/1.25)
                for i in 0...(cardVM.cardLocations.count-1) {
                    cardVM.cardLocations[i] = CGPoint(x: newValue.width/2, y: newValue.height/1.25)
                }
            }
            .onDisappear {
                isGameView = false
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


