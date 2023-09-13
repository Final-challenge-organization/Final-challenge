//
//  Card.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 05/09/23.
//

import Foundation

struct Card: Datable, Codable, Hashable {
    let id: Int
    let name: String
    let type: CardType
    let damage: Int

    func toData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}

enum CardType: String, Codable {
    case action = "action"
    case reaction = "reaction"
}


