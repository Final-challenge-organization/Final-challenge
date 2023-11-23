//
//  PlayersMock.swift
//  Mythos
//
//  Created by Narely Lima on 09/11/23.
//

import Foundation

var playersMock = [
    PlayerClient(id: UUID(), name: "Jogador 1", deck: deckMock.shuffled(), life: 30, isYourTurn: true, isReaction: false, handCards: [deckMock[0],deckMock[1],deckMock[2]], image: Data()),
    PlayerClient(id: UUID(), name: "Jogador 2", deck: deckMock.shuffled(), life: 30, isYourTurn: false, isReaction: false, handCards: [deckMock[2],deckMock[1],deckMock[3]], image: Data()),
    PlayerClient(id: UUID(), name: "Jogador 3", deck: deckMock.shuffled(), life: 30, isYourTurn: false, isReaction: false, handCards: [deckMock[2],deckMock[3],deckMock[0]], image: Data()),
    PlayerClient(id: UUID(), name: "Jogador 4", deck: deckMock.shuffled(), life: 30, isYourTurn: false, isReaction: false, handCards: [deckMock[2],deckMock[0],deckMock[3]], image: Data()),
]
