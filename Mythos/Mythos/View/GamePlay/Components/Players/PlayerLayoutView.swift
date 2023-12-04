//
//  PlayerLayoutView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 27/10/23.
//

import SwiftUI

struct PlayerLayoutView: View {

    @ObservedObject var cardVM: CardViewModel

    @EnvironmentObject var websocket: WebSocket
    @EnvironmentObject var tutorialModel: TutorialModel

    @State var isGameView: Bool

    var body: some View {
        if isGameView {
            ForEach(Array(websocket.connectedPlayers.enumerated()), id: \.element.id) { index, player in
                if websocket.myPlayerReference == player {
                        generatePlayerLayout(for: index, players: websocket.connectedPlayers)
                }
            }
        } else {
            generatePlayerLayout(for: 0, players: tutorialModel.connectedPlayers)
        }

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
            VStack(alignment: .center) {
                PersonasView(cards: thirdPlayer.handCards,
                             namePerson: thirdPlayer.name,
                             lifePerson: (thirdPlayer.life <= 0) ? 0 : thirdPlayer.life,
                             index: (players.count < 3) ? 5 : 2,
                             isYourTurn: thirdPlayer.isYourTurn, image: thirdPlayer.image
                             )

                HStack {
                    PersonasView(cards: secondPlayer.handCards,
                                 namePerson: secondPlayer.name,
                                 lifePerson: (secondPlayer.life <= 0) ? 0 : secondPlayer.life,
                                 index: (players.count < 2) ? 5 : 1,
                                 isYourTurn: secondPlayer.isYourTurn, image: secondPlayer.image)
                    Spacer()

                    PersonasView(cards: lastPlayer.handCards, namePerson: lastPlayer.name,
                                 lifePerson: (lastPlayer.life <= 0) ? 0 : lastPlayer.life,
                                 index: (players.count < 4) ? 5 : 3,
                                 isYourTurn: lastPlayer.isYourTurn, image: lastPlayer.image)

                }
                PersonasView(cards: firstPlayer.handCards,
                             namePerson: firstPlayer.name,
                             lifePerson: (firstPlayer.life <= 0) ? 0 : firstPlayer.life,
                             index: 0,
                             isYourTurn: firstPlayer.isYourTurn, image: firstPlayer.image)
            }
        }
        return viewPersonas
    }
    var layoutTutorial: some View {
        generatePlayerLayout(for: 0, players: tutorialModel.connectedPlayers)
    }
}

//struct PlayerLayoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerLayoutView()
//    }
//}
