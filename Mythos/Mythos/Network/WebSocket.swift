//
//  WebSocket.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 05/09/23.
//

import UIKit

class WebSocket: ObservableObject, WebSocketProtocol {
    @Published var isGameOver: Bool? = nil
    @Published var connectedPlayers: [PlayerClient] = []
    @Published var cardsPlayed: [Card] = []
    private let serverIp = "143.110.157.204:8080"

    @Published var winner: Bool = false
    private var myID = UUID()
    var isAllPlayersConnecteds: Bool {
        return (connectedPlayers.count == 4) ? true : false
    }
    var turnPlayer: String {
        let player = self.connectedPlayers.first {$0.isYourTurn == true} ?? PlayerClient(id: UUID(), name: "ANONIMO", deck: [], life: 2, isYourTurn: false, isReaction: false, handCards: [])
        if player.id == self.myID {
            return "Seu Turno"
        } else {
            return "Turno de \(player.name)"
        }
    }
    var myPlayerReference: PlayerClient {
        return connectedPlayers.first { $0.id == self.myID} ?? PlayerClient(id: UUID(), name: "ANONIMO", deck: [], life: 2, isYourTurn: false, isReaction: false, handCards: [])
    }

    private var contentTypeCardReference: ContentType {
        if (self.myPlayerReference.isReaction && self.myPlayerReference.isYourTurn) {
            return ContentType.reactionToServer
        }
        if (!self.myPlayerReference.isReaction && self.myPlayerReference.isYourTurn) {
            return ContentType.cardToServer

        }
        else {
            print("INEXPECTED")
            return .reactionToClient
        }
    }

    private var webSocketTask: URLSessionWebSocketTask?
    private var httpTask: URLSessionDataTask?

    func serverConnect() {
        self.verifyNumberOfRoom()
    }

    internal func verifyNumberOfRoom() {
<<<<<<< HEAD:Mythos/Mythos/Model/WebSocket.swift
        guard let url = URL(string: "http://luiz.local:8080/verifyRoom") else {return}
=======
        guard let url = URL(string: "http://\(serverIp)/verifyRoom") else {return}
>>>>>>> develop:Mythos/Mythos/Network/WebSocket.swift
        let request = URLRequest(url: url)
        httpTask = URLSession.shared.dataTask(with: request, completionHandler: { data , response, error in
            guard let data = data else {
                print("Nenhum dado recebido")
                return
            }
            let unwrappedData = try! JSONDecoder().decode(Int.self, from: data)
            print(unwrappedData)
            DispatchQueue.main.async {
                self.connect(unwrappedData)
            }
        })
        httpTask?.resume()
    }

    internal func connect(_ roomNumber: Int) {
<<<<<<< HEAD:Mythos/Mythos/Model/WebSocket.swift
        guard let url = URL(string: "ws://luiz.local:8080/websocket/\(roomNumber)") else { return } // ajeitar a porta
=======
        guard let url = URL(string: "ws://\(serverIp)/websocket/\(roomNumber)") else { return } // ajeitar a porta
>>>>>>> develop:Mythos/Mythos/Network/WebSocket.swift
        let request = URLRequest(url: url)
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        receiveMessage()
        let dataStorage = DataStorage()
        dataStorage.loadUserName()
        let playerName = dataStorage.getUserName()

        self.sendData(DataWrapper(playerID: UUID(), contentType: .sendUserNameToServer, content: playerName.toData()))
    }

    // é preciso melhorar essa funcao a cargo de quando houver disconnect ele nao continuar de forma recursiva
    internal func receiveMessage() {
        webSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                return
            case .success(let message):
                switch message {
                case .string(let text):
                    print(text)
                case .data(let data):
                    let decodedData = try! JSONDecoder().decode(DataWrapper.self, from: data)
                    switch decodedData.contentType {
                    case .nameToClient:
                        if let decodedContent = self.decodeData([PlayerClient].self, data: decodedData.content) {
                            DispatchQueue.main.async {
                                self.connectedPlayers = decodedContent
                                self.myID = decodedData.playerID
                            }
                        }
                        print(decodedData.contentType)
                    case .deckToClient:
                        if let decodedContent = self.decodeData([PlayerClient].self, data: decodedData.content) {
                            DispatchQueue.main.async {
                                self.connectedPlayers = decodedContent
                            }
                        }
                        print(decodedData.contentType)

                    case .lifeToClient:
                        if let decodedContent = self.decodeData([PlayerClient].self, data: decodedData.content) {
                            DispatchQueue.main.async {
                                self.connectedPlayers = decodedContent
                            }
                        }
                        print(decodedData.contentType)
                    case .turnToClient:
                        if let decodedContent = self.decodeData([PlayerClient].self, data: decodedData.content) {

                            DispatchQueue.main.async {
                                self.connectedPlayers = decodedContent
                            }
                        }
                        print(decodedData.contentType)
                    case .reactionToClient:
                        if let decodedContent = self.decodeData([PlayerClient].self, data: decodedData.content) {
                            DispatchQueue.main.async {
                                self.connectedPlayers = decodedContent
                            }
                        }
                        print(decodedData.contentType)
                    case .handCardsToClient:
                        if let decodedContent = self.decodeData([PlayerClient].self, data: decodedData.content) {
                            DispatchQueue.main.async {
                                self.connectedPlayers = decodedContent
                            }
                        }
                        print(decodedData.contentType)
                    case .connectedPlayersToClient:
                        if let decodedContent = self.decodeData([PlayerClient].self, data: decodedData.content) {
                            DispatchQueue.main.async {
                                self.connectedPlayers = decodedContent
                                print("Atualmente com: \(self.connectedPlayers.count) players")
                            }
                        }
                        print(decodedData.contentType)
                    case .cardsPlayedToClient:
                        if let decodedContent = self.decodeData([Card].self, data: decodedData.content) {
                            DispatchQueue.main.async {
                                self.cardsPlayed = decodedContent
                            }
                        }
                        print(decodedData.contentType)
                    case .gameplayStatusToClient:
                        if let decodedContent = self.decodeData(Bool.self, data: decodedData.content) {
                            DispatchQueue.main.async {
                                if decodedContent {
                                    print("Ganhou")
                                    self.winner = true
                                    self.isGameOver = decodedContent
                                } else {
                                    print("Perdeu")
                                    self.winner = false
                                    self.isGameOver = decodedContent
                                }
                                self.webSocketTask?.cancel()
                            }
                        }
                        print(decodedData.contentType)
                    default:
                        print("default")
                    }
                @unknown default:
                    break
                }
            }
            self.receiveMessage()
        }
    }
        

    func sendMessage(_ message: String) {
        guard let _ = message.data(using: .utf8) else { return } // Data
        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func sendData(_ data: DataWrapper) {
        let encoded = try! JSONEncoder().encode(data)
        webSocketTask?.send(.data(encoded)) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    private func decodeData<T: Codable>(_ type: T.Type, data: Data) -> T? {
        do{
            let decodeData = try JSONDecoder().decode(type.self, from: data)
            return decodeData
        } catch {
            print(error)
        }
        return nil
    }

    func sendCard(with card: Card?) {
        let encoder = try! JSONEncoder().encode(card)
        let dataWrapper = DataWrapper(playerID: self.myID, contentType: self.contentTypeCardReference, content: encoder)
        self.sendData(dataWrapper)
    }
}


extension Array: Datable where Element: Codable {
    func toData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}

extension String: Datable {
    func toData() -> Data {
        return try! JSONEncoder().encode(self)
    }
}
