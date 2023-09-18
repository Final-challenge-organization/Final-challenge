//
//  GameView.swift
//  Mythos
//
//  Created by Narely Lima on 04/09/23.
//

import SwiftUI
import SpriteKit

struct GameView: View {

    @EnvironmentObject var webSocket: WebSocket

//    var scene: GameSceneTeste {
//        let scene = GameSceneTeste()
//        scene.scaleMode = .fill
//        return scene
//    }
    var scene = GameSceneTeste(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
            .onChange(of: webSocket.playerID, perform: { newValue in // mudar para avatar pessoa
                scene.addPlayerNode(player: SKSpriteNode(imageNamed: "carol"))
            })
            .onChange(of: webSocket.cardsPlayed) { newValue in
                scene.makeHandCards(from: newValue)
            }
    }

}

 class GameSceneTeste: SKScene {

     var handCards: [CardNode] = []
     let background = SKSpriteNode(imageNamed: "back")
     var player1 = SKSpriteNode(imageNamed: "luiz")
     let player2 = SKSpriteNode(imageNamed: "luiz")
     let player3 = SKSpriteNode(imageNamed: "cicero")
     let player4 = SKSpriteNode(imageNamed: "sara")
     let killDeck = SKSpriteNode(imageNamed: "killDeck")
     let deck = SKSpriteNode(imageNamed: "deck")
     let life = SKLabelNode(text: "AODKAOSKOADSK")

     fileprivate func placeHandCard(card: CardNode) {
         addChild(card)
         card.size = CGSize(width: size.width/10 , height: size.height/4)
         card.position = CGPoint(x: size.width/2, y: size.height/7)
         card.zPosition = 2
     }

     override func didMove(to view: SKView) {


         if handCards.isEmpty {
             print("ta vazio")
         } else {
             for card in handCards {
                 placeHandCard(card: card)
             }
         }

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

         addChild(life)
         life.fontSize = 50
         life.position = CGPoint(x: frame.midX, y: frame.midY)


     }

     func makeHandCards(from cards: [Card]) {
         handCards = cards.map { _ in CardNode(cardTexture: SKTexture(imageNamed: "demeter")) }
         handCards.forEach { placeHandCard(card: $0) }
     }

     func addPlayerNode(player: SKSpriteNode) {
         addChild(player)
         player.size = CGSize(width: size.width/8 , height: size.height/4)
         player.position = CGPoint(x: size.width/2, y: size.height/3)
         player.zPosition = 2
     }

}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
