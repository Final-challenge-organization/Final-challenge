//
//  WebSocket.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 05/09/23.
//

import Foundation

class WebSocket: ObservableObject {
    @Published var deck: [Card]? =  nil
    private var webSocketTask: URLSessionWebSocketTask?

    init(){
        self.connect()
    }

    private func connect() {
        guard let url = URL(string: "ws://luiz.local:8100/match/1") else {return}
        let request = URLRequest(url: url)
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        reciveMessage()
    }

    private func reciveMessage() {
        webSocketTask?.receive { result in
            switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let message):
                    switch message {
                        case .string(let text):
                            print(text)
                        case .data(let data):
                            print(data)
                            let decoded = self.decodeData([Card].self, data: data)
                            self.deck = decoded
                        @unknown default:
                            break
                    }
            }
            self.reciveMessage()
        }
    }

    func sendMessage(_ message: String) {
        guard let _ = message.data(using: .utf8) else {return}
        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func sendData(_ data: DataWrapper){
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
