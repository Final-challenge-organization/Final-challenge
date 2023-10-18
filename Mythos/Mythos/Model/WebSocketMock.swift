////
////  WebSocketMock.swift
////  Mythos
////
////  Created by Cicero Nascimento on 17/10/23.
////
//
//import Foundation
//
//class WebSocketMock: WebSocketProtocol, ObservableObject {
//    func serverConnect() {
//        <#code#>
//    }
//
//    func verifyNumberOfRoom() {
//        <#code#>
//    }
//
//    func connect(_ roomNumber: Int) {
//        <#code#>
//    }
//
//    func receiveMessage() {
//        <#code#>
//    }
//
//    func sendMessage(_ message: String) {
//        <#code#>
//    }
//
//    func sendData(_ data: DataWrapper) {
//        <#code#>
//    }
//
//    func sendCard(with card: Card?) {
//        <#code#>
//    }
//
//    var isAllPlayersConnecteds: Bool
//
//    var turnPlayer: String
//
//    var myPlayerReference: PlayerClient
//
//
//
//    @Published var isGameOver: Bool? = nil
//    @Published var connectedPlayers: [PlayerClient] = []
//    @Published var cardsPlayed: [Card] = []
//
//    private var myID = UUID()
//    private var contentTypeCardReference: ContentType = .reactionToClient
//    private var webSocketTask: URLSessionWebSocketTask?
//    private var httpTask: URLSessionDataTask?
//
//    init() {
//        connectedPlayers = [
//            PlayerClient(id: UUID(), name: "Player1", deck: [], life: 10, isYourTurn: true, isReaction: false, handCards: []),
//            PlayerClient(id: UUID(), name: "Player2", deck: [], life: 8, isYourTurn: false, isReaction: false, handCards: []),
//            PlayerClient(id: UUID(), name: "Player3", deck: [], life: 6, isYourTurn: false, isReaction: true, handCards: []),
//            PlayerClient(id: myID, name: "You", deck: [], life: 12, isYourTurn: true, isReaction: false, handCards: [])
//        ]
//
//        isGameOver = false
//        cardsPlayed = []
//    }
//
//}
