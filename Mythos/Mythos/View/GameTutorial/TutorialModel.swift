//
//  TutorialModel.swift
//  Mythos
//
//  Created by Narely Lima on 09/11/23.
//

import Foundation

class TutorialModel: ObservableObject {

    @Published var isGameOver: Bool? = nil
    @Published var connectedPlayers: [PlayerClient] = playersMock
    @Published var cardsPlayed: [Card] = []
    @Published var winner: Bool = false
    @Published var isShowingAnimationBlock: Bool = false

    private var myID = UUID()

    var turnPlayer: String {
        let player = self.connectedPlayers.first {$0.isYourTurn == true} ?? PlayerClient(id: UUID(), name: "ANONIMO", deck: [], life: 2, isYourTurn: false, isReaction: false, handCards: [], image: Data())
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
    }

    func nextPlayer(_ indexOfLastPlayer: Int) -> Int {
        let nextIndex = (indexOfLastPlayer + 1) % connectedPlayers.count
        return nextIndex
    }
}
