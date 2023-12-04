//
//  TutorialModel.swift
//  Mythos
//
//  Created by Narely Lima on 09/11/23.
//

import Foundation

class TutorialModel: ObservableObject {

    @Published var connectedPlayers: [PlayerClient] = playersMock
    @Published var winner: Bool = false
    @Published var isGameOver: Bool = false
    @Published var cardsPlayed: [Card] = []
    @Published var isShowingAnimationBlock: Bool = false
    @Published var matchNumberTutorial: Int = 1

    private var myID = UUID()

    var turnPlayer: String {
        let player = self.connectedPlayers.first {$0.isYourTurn == true} ?? PlayerClient(id: UUID(), name: "Anonimo", deck: [], life: 2, isYourTurn: false, isReaction: false, handCards: [], image: Data())
        switch player.name {
        case "Jogador 1":
            return "Seu Turno"
        case "Jogador 2":
            return "Turno de Jogador 2"
        case "Jogador 3":
            return "Turno de Jogador 3"
        case "Jogador 4":
            return "Turno de Jogador 4"
        default:
            return ""
        }
    }

    func sendCard(with card: Card) {
        cardsPlayed.append(card)
        if connectedPlayers[0].isReaction {
            connectedPlayers[0].isReaction = false
        }
        if connectedPlayers[0].isYourTurn {
            connectedPlayers[0].isYourTurn = false
        }
    }

    func nextPlayer(_ indexOfLastPlayer: Int) -> Int {
        let nextIndex = (indexOfLastPlayer + 1) % connectedPlayers.count
        return nextIndex
    }

    func resetTutorialModel() {
        connectedPlayers = playersMock
        cardsPlayed = []
        isShowingAnimationBlock = false
        matchNumberTutorial = 1
    }
}
