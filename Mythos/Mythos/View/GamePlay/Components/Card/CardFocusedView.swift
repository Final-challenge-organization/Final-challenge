//
//  CardFocusedView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 24/10/23.
//

import SwiftUI

struct CardFocusedView: View {
    var card: Card

    @Binding var isTapped: Bool

    var body: some View {
        CardRepresentable(card: card) {
            withAnimation {
                isTapped = false
            }
        }
    }
}

struct CardFocusedView_Previews: PreviewProvider {
    static var previews: some View {
        CardFocusedView(card: Card(uuid: UUID(), id: 0, name: "aokdoas", imageName: "flechaEncantada", type: .action(.damage), damage: 10, effect: "aokdoaskaosdk", description: "adkadoaskdoaskdoaskdasokdsosd", descTutorial: "fsdf"), isTapped: .constant(false))
            .frame(width: 400, height: 500)
    }
}
