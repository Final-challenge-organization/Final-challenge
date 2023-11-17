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
    var showDescription: Bool = false

    var body: some View {
        ZStack {
            background
            cards
            showDescription ? description : nil
        }
    }

    var background: some View {
        Rectangle()
            .foregroundColor(.black)
            .opacity(0.5)
            .ignoresSafeArea()
    }
    var cards: some View {
        CardFocusedView(card: card, isTapped: $cardVM.killTapped)
            .frame(width: 744/3.5, height: 1039/3.5)
            .offset(x: offSetValuex, y: offSetValuey)
    }
    var description: some View {
        DescriptionTutorial(description: cardVM.description)
            .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/1.8)
            .position(x: UIScreen.main.bounds.width/6.5, y: UIScreen.main.bounds.height/1.5)
    }
}

//struct CardsHighlightsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardHighlightsView()
//    }
//}
