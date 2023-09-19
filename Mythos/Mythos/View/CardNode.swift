//
//  CardNode.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 15/09/23.
//

import Foundation
import SpriteKit

class CardNode: SKSpriteNode {

    let cardTexture: SKTexture


    init(cardTexture: SKTexture) {
        self.cardTexture = cardTexture
        super.init(texture: cardTexture, color: .clear, size: cardTexture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
