//
//  CardStackView.swift
//  Mythos
//
//  Created by Luiz Sena on 14/11/23.
//

import SwiftUI

struct CardStackView: View {
    let card: Card?
    @Binding var tapped: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(style: .init(lineWidth: 0, dash: [10]))
            .background {
                Image("playCardsBackground")
                    .resizable()
                    .frame(width: 100, height: 140)
                    .scaledToFill()
            }
            .overlay {
                if let card = card {
                    CardRepresentable(card: card) {
                        withAnimation {
                            tapped = true
                        }
                    }
                }
            }

    }
}

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView(card: Card(id: 0, name: "opa", imageName: "sandaliaAladas", type: .reaction, damage: 0, effect: "AAA", description: "AAAAAAA"), tapped: .constant(false))
            .previewDisplayName("with card")
        CardStackView(card: nil, tapped: .constant(false))
            .previewDisplayName("nil value of card")
    }
}
