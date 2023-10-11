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

        GeometryReader { geo in
            if card.type == .action {
                Image("actionCard")
                    .resizable()
                    .scaledToFit()
                    .overlay(content: {
                        VStack {
                            Spacer()
                            Text("Cause: \(card.damage)")
                                .font(MyCustomFonts.ConvergenceRegular.font)
                                .foregroundColor(.white)
                                .scaledToFill()
                                .padding(.bottom, 25)
                        }
                    })
                    .overlay {
                        (isYourTurn && !isReaction) ? Color.clear : Color.gray.opacity(0.5)
                    }
                    .onTapGesture {
                        if (isYourTurn && !isReaction) {
                            onTap()
                        }
                    }
            }
            if card.type == .reaction {
                Image("reactionCard")
                    .resizable()
                    .scaledToFit()
                    .overlay(content: {
                        VStack {
                            Spacer()
                            Text("Defenda: \(card.damage)")
                                .font(MyCustomFonts.ConvergenceRegular.font)
                                .foregroundColor(.white)
                                .scaledToFill()
                                .padding(.bottom, 25)
                        }
                    })
                    .overlay {
                        (isYourTurn || isReaction) ? Color.clear : Color.gray.opacity(0.5)
                    }
                    .onTapGesture {
                        if (isYourTurn || isReaction) {
                            onTap()
                        }
                    }
            }
        }

    }
}

struct CardRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardRepresentable(isYourTurn: true, isReaction: true, card: Card(id: 0, name: "", type: .action, damage: 10), onTap: {})
                .frame(width: 200, height: 250)
//            CardRepresentable(isYourTurn: true, isReaction: true, card: Card(id: 0, name: "", type: .reaction, damage: 10), onTap: {})
//                .frame(width: 200, height: 250)
        }
    }
}

