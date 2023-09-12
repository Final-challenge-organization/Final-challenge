//
//  DataWrapper.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 06/09/23.
//

import Foundation

struct DataWrapper: Codable {
    let contentType: ContentType
    var content: Data

    func decodeContent<T: Decodable>() -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: content)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }

    mutating func encodeContent<T: Encodable>(_ object: T) {
        switch contentType {
            case .card:
                do {
                    self.content = try JSONEncoder().encode(object)
                } catch {
                    print(error)
                }
            case .deck:
                do {
                    self.content = try JSONEncoder().encode(object)
                } catch {
                    print(error)
                }
        }
        print("Nao entrou no switch|case")
    }
}

enum ContentType: Codable {
    case card
    case deck
}
