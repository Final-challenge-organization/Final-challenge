//
//  WebSocketProtocol.swift
//  Mythos
//
//  Created by Cicero Nascimento on 17/10/23.
//

import Foundation

protocol WebSocketProtocol {
    var isGameOver: Bool? { get set }
    var connectedPlayers: [PlayerClient] { get set }
    var cardsPlayed: [Card] { get set }
    var isAllPlayersConnecteds: Bool { get }
    var turnPlayer: String { get }
    var myPlayerReference: PlayerClient { get }

    func serverConnect()
    func verifyNumberOfRoom()
    func connect(_ roomNumber: Int)
    func receiveMessage()
    func sendMessage(_ message: String)
    func sendData(_ data: DataWrapper)
    func sendCard(with card: Card?)
}
