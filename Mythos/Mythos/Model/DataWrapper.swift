//
//  DataWrapper.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 06/09/23.
//

import Foundation

struct DataWrapper: Codable {
    let playerID: UUID
    let contentType: ContentType
    let content: Data
}

enum ContentType: Codable {
    case sendUserNameToServer
    case cardToServer
    case reactionToServer

    case reactionToClient
    case nameToClient
    case connectedPlayersToClient
    case lifeToClient
    case handCardsToClient
    case deckToClient
    case turnToClient
    case cardsPlayedToClient
}

