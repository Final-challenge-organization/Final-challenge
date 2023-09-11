//
//  Card.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 05/09/23.
//

import Foundation

struct Card: Codable {
    let id: Int
    let name: String
    let type: CardType
}

enum CardType: String, Codable {
    case action = "action"
    case reaction = "reaction"
}
