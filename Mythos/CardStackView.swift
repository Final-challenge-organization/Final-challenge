//
//  CardStackView.swift
//  Mythos
//
//  Created by Luiz Sena on 14/11/23.
//

import SwiftUI

struct CardStackView: View {
    let card: Card?
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .stroke(style: .init(lineWidth: 5))
            .overlay {
                if let card = card {
                    CardRepresentable(card: card) {
                        print()
                    }
                }
            }
            .rotationEffect(.degrees(90))
    }
}

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView(card: Card(id: 0, name: "opa", imageName: "sandaliaAladas", type: .reaction, damage: 0, effect: "AAA", description: "AAAAAAA"))
            .previewDisplayName("with card")
        CardStackView(card: nil)
            .previewDisplayName("nil value of card")
    }
}
