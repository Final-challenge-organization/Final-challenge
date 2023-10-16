//
//  PlayerClient.swift
//  Mythos
//
//  Created by Luiz Sena on 06/10/23.
//

import Foundation

struct PlayerClient: Codable, Datable, Equatable {
    var id: UUID
    let name: String
    var deck: [Card]
    var life: Int
    var isYourTurn: Bool
    var isReaction: Bool
    var handCards: [Card]

    func toData() -> Data {
        try! JSONEncoder().encode(self)
    }
}


