//
//  ModelGame.swift
//  Mythos
//
//  Created by Narely Lima on 05/09/23.
//

import Foundation

struct Player {
    var id = Int()
    var name = String()
    var life: Int = 30
    var individualsCards = [Cards]()
}

struct Cards: Equatable {
    var id = Int()
    var typeOfCards = TypesOfCards.attack
//  var description: String = ""
    var damage = Int()
}

enum TypesOfCards {
    case attack
    case defense
    case specialEffect
}


let cards: [Cards] = [Cards(id: 0, typeOfCards: .attack, damage: 5),
                      Cards(id: 1, typeOfCards: .attack, damage: 2),
                      Cards(id: 2, typeOfCards: .attack, damage: 3),
                      Cards(id: 3, typeOfCards: .attack, damage: 1),
                      Cards(id: 4, typeOfCards: .attack, damage: 6),
                      Cards(id: 5, typeOfCards: .attack, damage: 2),
                      Cards(id: 6, typeOfCards: .attack, damage: 3),
                      Cards(id: 7, typeOfCards: .attack, damage: 4),
                      Cards(id: 8, typeOfCards: .attack, damage: 5),
                      Cards(id: 9, typeOfCards: .attack, damage: 1),
                      Cards(id: 10, typeOfCards: .defense, damage: 2),
                      Cards(id: 11, typeOfCards: .defense, damage: 3),
                      Cards(id: 12, typeOfCards: .defense, damage: 1),
                      Cards(id: 13, typeOfCards: .defense, damage: 6),
                      Cards(id: 14, typeOfCards: .defense, damage: 2),
                      Cards(id: 15, typeOfCards: .defense, damage: 1),
                      Cards(id: 16, typeOfCards: .defense, damage: 7),
                      Cards(id: 17, typeOfCards: .specialEffect, damage: 0),
                      Cards(id: 18, typeOfCards: .specialEffect, damage: 1),
                      Cards(id: 19, typeOfCards: .specialEffect, damage: 1),
                      Cards(id: 20, typeOfCards: .specialEffect, damage: 1),
                      Cards(id: 21, typeOfCards: .specialEffect, damage: 1),
                      ]
