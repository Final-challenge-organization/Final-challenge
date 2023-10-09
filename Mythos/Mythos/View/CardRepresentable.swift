//
//  CardRepresentabl.swift
//  Mythos
//
//  Created by Luiz Sena on 05/10/23.
//

import SwiftUI

struct CardRepresentable: View {
    var isYourTurn : Bool
    var isReaction: Bool
    var card: Card
    var onTap: () -> Void

    var body: some View {

        if card.type == .action {
            Rectangle()
                .frame(width: 75, height: 85)
                .foregroundColor((isYourTurn && !isReaction) ? .blue : .pink)
                .overlay(content: {
                    VStack {
                        Text(card.name)
                        Text("Cause: \(card.damage) de dano")
                    }
                })
                .onTapGesture {

                    if (isYourTurn && !isReaction) {
                        onTap()
                    }
                }

        }
        if card.type == .reaction {
            Rectangle()
                .frame(width: 75, height: 85)
                .foregroundColor((isYourTurn || isReaction) ? .blue : .pink)
                .overlay(content: {
                    VStack {
                        Text(card.name)
                        Text("Defenda: \(card.damage) de dano")
                    }
                })
                .onTapGesture {

                    if (isYourTurn || isReaction) {
                        onTap()
                    }
                }
        }
    }
}
