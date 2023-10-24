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
        if (card.type == .action(.damage)) || (card.type == .action(.block)) {
            Image("actionCard")
                .resizable()
                .scaledToFit()
                .offset(y: isTapped ? 40 : -40)
                .opacity(isTapped ? 1 : 0)
                .overlay(content: {
                    VStack {
                        Spacer()
                        Text("Cause: \(card.damage)")
                            .font(MyCustomFonts.ConvergenceRegular.font)
                            .foregroundColor(.white)
                            .scaledToFill()
                            .padding(.bottom, 30)
                    }
                    .offset(y: isTapped ? 40 : -40)
                    .opacity(isTapped ? 1 : 0)
                })
        }
        if card.type == .reaction {
            Image("reactionCard")
                .resizable()
                .scaledToFit()
                .offset(y: isTapped ? 40 : -40)
                .opacity(isTapped ? 1 : 0)
                .overlay(content: {
                    VStack {
                        Spacer()
                        Text("Defenda: \(card.damage)")
                            .font(MyCustomFonts.ConvergenceRegular.font)
                            .foregroundColor(.white)
                            .scaledToFill()
                            .padding(.bottom, 30)
                    }
                    .offset(y: isTapped ? 40 : -40)
                    .opacity(isTapped ? 1 : 0)
                })
        }
    }
}

//struct CardFocusedView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardFocusedView()
//    }
//}
