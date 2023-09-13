//
//  GameView.swift
//  Mythos
//
//  Created by Narely Lima on 04/09/23.
//

import SwiftUI
import SpriteKit

struct GameView: View {

    var scene: SKScene {
        let scene = GameScene()
        scene.scaleMode = .fill
        return scene

    }

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }

}

 class GameScene: SKScene {

     let card = SKSpriteNode(imageNamed: "demeter")
     let background = SKSpriteNode(imageNamed: "back")
     let player1 = SKSpriteNode(imageNamed: "carol")
     let player2 = SKSpriteNode(imageNamed: "luiz")
     let player3 = SKSpriteNode(imageNamed: "cicero")
     let player4 = SKSpriteNode(imageNamed: "sara")
     let killDeck = SKSpriteNode(imageNamed: "killDeck")
     let deck = SKSpriteNode(imageNamed: "deck")

     override func didMove(to view: SKView) {

         addChild(card)
         card.size = CGSize(width: size.width/10 , height: size.height/4)
         card.position = CGPoint(x: size.width/2, y: size.height/7)
         card.zPosition = 1

         addChild(background)
         background.zPosition = 0
         background.size = CGSize(width: size.width , height: size.height)
         background.position = CGPoint(x: size.width/2, y: size.height/2)

         addChild(player1)
         player1.size = CGSize(width: size.width/8 , height: size.height/4)
         player1.position = CGPoint(x: size.width/2, y: size.height/3)
         player1.zPosition = 1

         addChild(player2)
         player2.size = CGSize(width: size.width/8 , height: size.height/4)
         player2.position = CGPoint(x: 0.16, y: size.height/2)
         player2.zPosition = 1

         addChild(player3)
         player3.size = CGSize(width: size.width/8 , height: size.height/4)
         player3.position = CGPoint(x: size.width/2, y: size.height/1.5)
         player3.zPosition = 1

         addChild(player4)
         player4.size = CGSize(width: size.width/8 , height: size.height/4)
         player4.position = CGPoint(x: size.width/1.2, y: size.height/2)
         player4.zPosition = 1

         addChild(killDeck)
         killDeck.size = CGSize(width: size.width/10 , height: size.height/4)
         killDeck.position = CGPoint(x: size.width/4.5, y: size.height/7)
         killDeck.zPosition = 2

         addChild(deck)
         deck.size = CGSize(width: size.width/10 , height: size.height/4)
         deck.position = CGPoint(x: size.width/1.3, y: size.height/7.5)
         deck.zPosition = 2

     }
//     override func sceneDidLoad() {
//         super.sceneDidLoad()
//
//     }

}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
