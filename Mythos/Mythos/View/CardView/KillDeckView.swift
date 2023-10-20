//
//  KillDeckView.swift
//  Mythos
//
//  Created by Narely Lima on 19/10/23.
//

import SwiftUI

struct KillDeckView: View {

    var card: Card

    var body: some View {
        GeometryReader { geo in
            if (card.type == .action(.damage)) || (card.type == .action(.block)) {
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
            }
        }
    }
}

struct KillDeckView_Previews: PreviewProvider {
    static var previews: some View {
        KillDeckView(card: Card(id: 0, name: "", type: .action(.damage), damage: 0, effect: "", description: ""))
    }
}
