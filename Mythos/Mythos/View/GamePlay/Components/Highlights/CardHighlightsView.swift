//
//  CardsHighlightsView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 27/10/23.
//

import SwiftUI

struct CardHighlightsView: View {
    
    @ObservedObject var cardVM: CardViewModel

    var offSetValuex: CGFloat
    var offSetValuey: CGFloat
    var card: Card

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    cardVM.killTapped = false
                }
            CardFocusedView(card: card, isTapped: $cardVM.killTapped)
                .frame(width: 744/3.5, height: 1039/3.5)
                .offset(x: offSetValuex, y:offSetValuey)
        }
    }
}

//struct CardsHighlightsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardHighlightsView()
//    }
//}
