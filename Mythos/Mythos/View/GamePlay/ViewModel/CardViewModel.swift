//
//  CardViewModel.swift
//  Mythos
//
//  Created by Cicero Nascimento on 27/10/23.
//

import Foundation
import UIKit

class CardViewModel: ObservableObject {
    @Published var cardSelected: Card? = nil
    @Published var isTapped: Bool = false
    @Published var killTapped: Bool = false
    @Published var graveyardPosition: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
    @Published var cardLocations: [CGPoint] = [CGPoint(), CGPoint(), CGPoint()]
    @Published var isDragging: Bool = false
    @Published var baseCardLocation: CGPoint = CGPoint()
    var sendCard: (() -> ())?


    func colision(currentLocation: CGPoint) {
//        print("COLISAO EM: " + abs(self.graveyardPosition.x - currentLocation.x).description + "  -  " + abs(self.graveyardPosition.y - currentLocation.y).description)
        if (abs(self.graveyardPosition.x - currentLocation.x) < 65) && (abs(self.graveyardPosition.y - currentLocation.y) < 75) {
            print("COLIDIU")
            sendCard?()
        } else {
            print("NADA AINDA")
        }
    }


    func cardLocationForIndex(index: Int) -> CGPoint {
        return self.cardLocations[index]
    }

    func isAbleToDrag(card: Card, isYourTurn: Bool, isReaction: Bool) -> Bool {
        switch card.type {
        case .action(.damage):
            return (isYourTurn && !(isReaction))
        case .action(.block):
            return (isYourTurn  && !(isReaction))
        case .reaction:
            return (isYourTurn  || isReaction)
        }
    }
}
