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
    case cardToServer
    case cardToClient
    case turnToClient
    case idToClient
    case deckToClient
}

