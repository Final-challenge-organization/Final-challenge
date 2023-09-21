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

    var scene = GameSceneTeste(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()

            .onChange(of: webSocket.playerID, perform: { newValue in // mudar para avatar pessoa
                scene.addPlayerNode(player: SKSpriteNode(imageNamed: "carol"))
            })
            .onChange(of: webSocket.deckOfCards) { newValue in
                scene.makeHandCards(from: newValue)
            }
            .onChange(of: webSocket.life) { newValue in
                scene.addLifeNode(life: SKLabelNode(text: "30"))
            }
    }
}

class GameSceneTeste: SKScene {

    var touchLocation: CGPoint = CGPoint()

    var deckWS: [CardNode] = []
    let background = SKSpriteNode(imageNamed: "back")
    var player1 = SKSpriteNode(imageNamed: "luiz")
    let player2 = SKSpriteNode(imageNamed: "luiz")
    let player3 = SKSpriteNode(imageNamed: "cicero")
    let player4 = SKSpriteNode(imageNamed: "sara")
    let killDeck = SKSpriteNode(imageNamed: "killDeck")
    let deck = SKSpriteNode(imageNamed: "deck")
    let life = SKLabelNode(text: "30")
    var handCards: [CardNode] = []

    fileprivate func placeHandCard(_ card: CardNode) {
        addChild(card)
        card.size = CGSize(width: size.width/10 , height: size.height/4)
        card.zPosition = 4
    }
    fileprivate func placeDeckCard(_ card: CardNode) {
        addChild(card)
        card.size = CGSize(width: size.width/10 , height: size.height/4)
        card.position = CGPoint(x: size.width/1.3, y: size.height/7.5)
        card.zPosition = 2
    }

    override func didMove(to view: SKView) {

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
        deck.zPosition = 3

        addChild(life)
        life.fontSize = 50
        life.position = CGPoint(x: frame.midX, y: frame.midY)


    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodesAtPoint = self.nodes(at: location)

            for node in nodesAtPoint {
                switch node {
                case handCards[0]:
                    touchLocation = CGPoint(x: size.width/2, y: size.height/5)
                    alterationsCards(0)
                    handCards[1].size = CGSize(width: size.width/10 , height: size.height/4)
                    handCards[2].size = CGSize(width: size.width/10 , height: size.height/4)
                    handCards[1].position = CGPoint(x: size.width/1.7, y: size.height/7)
                    handCards[2].position = CGPoint(x: size.width/2.5, y: size.height/7)
                    handCards[1].zPosition = 3
                    handCards[2].zPosition = 3
                case handCards[1]:
                    touchLocation = CGPoint(x: size.width/1.7, y: size.height/5)
                    alterationsCards(1)
                    handCards[0].size = CGSize(width: size.width/10 , height: size.height/4)
                    handCards[2].size = CGSize(width: size.width/10 , height: size.height/4)
                    handCards[0].position = CGPoint(x: size.width/2, y: size.height/7)
                    handCards[2].position = CGPoint(x: size.width/2.5, y: size.height/7)
                    handCards[0].zPosition = 3
                    handCards[2].zPosition = 3
                case handCards[2]:
                    touchLocation = CGPoint(x: size.width/2.5, y: size.height/5)
                    alterationsCards(2)
                    handCards[0].size = CGSize(width: size.width/10 , height: size.height/4)
                    handCards[1].size = CGSize(width: size.width/10 , height: size.height/4)
                    handCards[0].position = CGPoint(x: size.width/2, y: size.height/7)
                    handCards[1].position = CGPoint(x: size.width/1.7, y: size.height/7)
                    handCards[0].zPosition = 3
                    handCards[1].zPosition = 3
                default:
                    print("Tocou em outro lugar")
                }
            }
        }
    }

//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let location = touch.location(in: self)
//            let nodesAtPoint = self.nodes(at: location)
//
//            for node in nodesAtPoint {
//                switch node {
//                case handCards[0]:
//                    touchLocation = CGPoint(x: size.width/2, y: size.height/7)
//                    alterationsCards(0)
//                case handCards[1]:
//                    touchLocation = CGPoint(x: size.width/1.7, y: size.height/7)
//                    alterationsCards(1)
//                case handCards[2]:
//                    touchLocation = CGPoint(x: size.width/2.5, y: size.height/7)
//                    alterationsCards(2)
//                default:
//                    print("Tocou em outro lugar")
//                }
//            }
//        }
//    }

    func alterationsCards(_ numberCard: Int) {
        handCards[numberCard].size = CGSize(width: size.width/8 , height: size.height/3)
        handCards[numberCard].position.x = (touchLocation.x)
        handCards[numberCard].position.y = (touchLocation.y)
        handCards[numberCard].zPosition = 5
    }

    func makeHandCards(from cards: [Card]) {
        deckWS = cards.map { _ in CardNode(cardTexture: SKTexture(imageNamed: "athena")) }
        print(deckWS)
        // 3 cartas que estão na mao do jogador
        for i in 0..<3 {
            handCards.append(deckWS[i])
        }
        // excluir as cartas que estao na mao do jogador do deck
        for _ in 0..<3 {
            deckWS.remove(at: 0)
        }
        // adicionar os nodes das cartas que estão no deck
        deckWS.forEach { placeDeckCard($0) }
        // adicionar os nodes das cartas que estão na mao
        handCards.forEach { placeHandCard($0)}
        // como as cartas da mao tem posições diferentes
        handCards[0].position = CGPoint(x: size.width/2, y: size.height/7)
        handCards[1].position = CGPoint(x: size.width/1.7, y: size.height/7)
        handCards[2].position = CGPoint(x: size.width/2.5, y: size.height/7)
    }

    func addPlayerNode(player: SKSpriteNode) {
        addChild(player)
        player.size = CGSize(width: size.width/8 , height: size.height/4)
        player.position = CGPoint(x: size.width/2, y: size.height/3)
        player.zPosition = 2
    }

    func addLifeNode(life: SKLabelNode) {
        addChild(life)
        life.position = CGPoint(x: size.width/2, y: size.height/2)
        life.zPosition = 2
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
