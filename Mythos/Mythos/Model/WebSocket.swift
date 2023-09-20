//
//  WebSocket.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 05/09/23.
//

import Foundation

class WebSocket: ObservableObject {
    @Published var isYourTurn: Bool = false
    @Published var playerID: UUID = UUID() // uuid que veio apos conexao do socket
    @Published var cardsPlayed: [Card] = []
    @Published var deckOfCards: [Card] = []
    @Published var life: Int = 30

    private var webSocketTask: URLSessionWebSocketTask?
//
//    init() {
//        self.connect()
//    }

    private func connect() {
      
        guard let url = URL(string: "ws://10.45.48.89:8111/websocket/1") else { return } // ajeitar a porta

        let request = URLRequest(url: url)
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        receiveMessage()
    }

    private func receiveMessage() {
        webSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let message):
                switch message {
                case .string(let text):
                    print(text)
                case .data(let data):

                    let decodedData = try! JSONDecoder().decode(DataWrapper.self, from: data)

                    switch decodedData.contentType {
                    case .turnToClient:
                        let decodedContent = try! JSONDecoder().decode(Bool.self, from: decodedData.content)
                        DispatchQueue.main.async {
                            self.isYourTurn = decodedContent
                        }
                    case .cardToClient:

                        let decodedContent = try! JSONDecoder().decode(Card.self, from: decodedData.content)
                        DispatchQueue.main.async {
                            self.cardsPlayed.append(decodedContent)
                        }
                    case .cardToServer:
                        print()
                    case .idToClient:
                        DispatchQueue.main.async {
                            self.playerID = decodedData.playerID

                        }
                    case .deckToClient:
                        let decodedContent = try! JSONDecoder().decode([Card].self, from: decodedData.content)

                        DispatchQueue.main.async {
                            self.deckOfCards = decodedContent
                        }
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
}
