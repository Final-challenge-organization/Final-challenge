//
//  KillDeckView.swift
//  Mythos
//
//  Created by Narely Lima on 19/10/23.
//

import SwiftUI

struct KillDeckView: View {

    var card: Card
    @Binding var killDecktapped: Bool

    var body: some View {
        if (card.type == .action(.damage)) || (card.type == .action(.block)) {
            Image("actionCard")
                .resizable()
                .scaledToFit()
                .rotationEffect(killDecktapped ? Angle(degrees: 0) : Angle(degrees: 90))
                .overlay(content: {
                    VStack {
                        Spacer()
                        Text("Cause: \(card.damage)")
                            .font(MyCustomFonts.ConvergenceRegular.font)
                            .foregroundColor(.white)
                            .scaledToFill()
                            .padding(.bottom, 30)
                    }.rotationEffect(killDecktapped ? Angle(degrees: 0) : Angle(degrees: 90))
                })
        }
        if card.type == .reaction {
            Image("reactionCard")
                .resizable()
                .scaledToFit()
                .rotationEffect(killDecktapped ? Angle(degrees: 0) : Angle(degrees: 90))
                .overlay(content: {
                    VStack {
                        Spacer()
                        Text("Defenda: \(card.damage)")
                            .font(MyCustomFonts.ConvergenceRegular.font)
                            .foregroundColor(.white)
                            .scaledToFill()
                            .padding(.bottom, 30)
                    }.rotationEffect(killDecktapped ? Angle(degrees: 0) : Angle(degrees: 90))
                })
        }
    }
}

//struct KillDeckView_Previews: PreviewProvider {
//    static var previews: some View {
//        KillDeckView()
//    }
//}
