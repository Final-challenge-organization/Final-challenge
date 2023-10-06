//
//  Card.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 05/09/23.
//

import Foundation

struct Card: Codable, Datable {
    var uuid: UUID = UUID()
    let id: Int
    let name: String
    let type: CardType
    let damage: Int

    func toData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}


enum CardType: Codable {
    case action
    case reaction
}



