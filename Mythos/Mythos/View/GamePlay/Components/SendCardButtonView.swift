//
//  SendCardButtonView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 27/10/23.
//

import SwiftUI

struct SendCardButtonView: View {

    @ObservedObject var cardVM: CardViewModel

    @EnvironmentObject var websocket: WebSocket


    var body: some View {
        Button {
            websocket.sendCard(with: cardVM.cardSelected)
            self.cardVM.isTapped = false
            self.cardVM.killTapped = false
        } label: {
            Image("button_descarte")
                .frame(maxWidth: 40, maxHeight: 40)
                .scaledToFit()
        }
        .offset(x: 250, y: 110)
        .disabled(!cardVM.isTapped)
    }
}

//struct SendCardButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        SendCardButtonView()
//    }
//}
