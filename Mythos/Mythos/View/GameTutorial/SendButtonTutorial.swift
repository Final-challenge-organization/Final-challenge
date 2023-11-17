//
//  SendButtonTutorial.swift
//  Mythos
//
//  Created by Narely Lima on 09/11/23.
//

import SwiftUI

struct SendButtonTutorial: View {

    @ObservedObject var cardVM: CardViewModel

    @EnvironmentObject var tutorialM: TutorialModel

    var body: some View {
        Button {
            self.cardVM.isTapped = false
            self.cardVM.killTapped = false
            if tutorialM.connectedPlayers[0].isReaction {
                tutorialM.sendCard(with: cardVM.cardSelected!)
                    tutorialM.connectedPlayers[0].isReaction = false
            }
            if tutorialM.connectedPlayers[0].isYourTurn {
                tutorialM.sendCard(with: cardVM.cardSelected!)
                tutorialM.connectedPlayers[0].isYourTurn = false
            }
        } label: {
            Image("button_descarte-2")
                .frame(maxWidth: 40, maxHeight: 40)
                .scaledToFit()
        }
        .offset(x: 250, y: 110)
        .disabled(!cardVM.isTapped)
    }
}
