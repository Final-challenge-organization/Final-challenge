//
//  Card.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 05/09/23.
//

import Foundation

struct Card: Codable, Datable, Equatable {
    var uuid: UUID = UUID()
    let id: Int
    let name: String
    let imageName: String
    let type: CardType
    let damage: Int
    let effect: String
    let description: String

    func toData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}


enum CardType: Codable, Equatable {
    case action(CardActionType)
    case reaction
}

enum CardActionType: Codable, Equatable {
    case block
    case damage
}



