//
//  PopUpCard.swift
//  Mythos
//
//  Created by Luiz Sena on 06/10/23.
//

import Foundation
import SwiftUI

struct PopUpCard: View {
    let card: Card
    @State var angle = Angle(degrees: 0)

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.gray)
                .frame(width: 150, height: 175)
                .overlay {
                    Text(card.name)
                        .font(.largeTitle)
                }
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 80, height: 250)
                .foregroundStyle(.linearGradient(Gradient(colors: [.pink, .purple, .indigo]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .rotationEffect(angle)
                .animation(.linear.repeatForever(autoreverses: false).speed(0.15), value: self.angle)
                .mask {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 4.5)
                        .frame(width: 150, height: 175)
                }
        }
        .onAppear {
            self.angle = Angle(degrees: 360)
        }
    }
}

struct PopUpCard_Previews: PreviewProvider {
    static var previews: some View {
        PopUpCard(card: Card(id: 0, name: "HADES", imageName: "escudoDeJustica", type: .action(.damage), damage: 10, effect: "HADES", description: "OMG", descTutorial: "socorro Deus"))
    }
}
