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
        GeometryReader { proxy in
            ZStack {
                ForEach(Array(websocket.myPlayerReference.handCards.enumerated()), id: \.element.uuid) { (index , card) in
                    CardRepresentable(isYourTurn: websocket.myPlayerReference.isYourTurn, isReaction: websocket.myPlayerReference.isReaction, card: card) {
                        cardVM.cardSelected = card
                        withAnimation {
                            cardVM.isTapped = true
                        }
                    }
                    .frame(width: 744/7, height: 1039/7)
                    .shadow(color: .brown.opacity(0.7), radius: 10)
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
                                    if cardVM.isAbleToDrag(card: card, isYourTurn: websocket.myPlayerReference.isYourTurn, isReaction: websocket.myPlayerReference.isReaction) {
                                        cardVM.cardLocations[index] = changedValue.location
                                        cardVM.isDragging = true
                                    }
                                }
                            })
                            .onEnded({ endedValue in
                                withAnimation {
                                    if cardVM.isAbleToDrag(card: card, isYourTurn: websocket.myPlayerReference.isYourTurn, isReaction: websocket.myPlayerReference.isReaction) {
                                        cardVM.cardLocations[index] = cardVM.baseCardLocation
                                        cardVM.isDragging.toggle()
                                        cardVM.sendCard = { websocket.sendCard(with: card) }
                                        cardVM.colision(currentLocation: endedValue.location)
                                    }
                                }
                            })
                    )
//                    .disabled(true)
                }
                .transition(.move(edge: .top))

                if websocket.turnPlayer == "Seu Turno" && isShowingYourTurn {
                    TurnIndicatorView()
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
            .animation(.easeInOut, value: websocket.myPlayerReference.handCards.count)
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
        }
    }
}
//
//struct UserCardsView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCardsView()
//    }
//}


