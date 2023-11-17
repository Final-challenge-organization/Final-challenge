//
//  PlayerLayoutTutorial.swift
//  Mythos
//
//  Created by Narely Lima on 09/11/23.
//

import Foundation
import SwiftUI

struct PlayerLayoutTutorial: View {

    @ObservedObject var cardVM: CardViewModel

    @EnvironmentObject var tutorialM: TutorialModel

    var body: some View {
        generatePlayerLayout(for: 0, players: tutorialM.connectedPlayers)
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
                             isYourTurn: thirdPlayer.isYourTurn
                             )

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
                    if (tutorialM.cardsPlayed.last != nil) {
                        Button {
                            withAnimation {
                                cardVM.killTapped.toggle()
                                cardVM.isTapped = false
                            }
                        } label: {
                            KillDeckView(card: tutorialM.cardsPlayed.last!, killDecktapped: $cardVM.killTapped)
                                .frame(width: 744/9, height: 1039/9)
                                .offset(x: cardVM.killTapped ? 110 : 0, y:0)
                                .opacity(cardVM.killTapped ? 0 : 1)
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
