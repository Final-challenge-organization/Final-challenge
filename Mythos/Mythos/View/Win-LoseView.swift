//
//  Win-LoseView.swift
//  Mythos
//
//  Created by Luiz Sena on 10/10/23.
//

import Foundation
import SwiftUI

struct PopupView: ViewModifier {

    @Binding var popupGameOver: Bool
    var winLoseText: String
    var dismissClosure: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            content
            if popupGameOver {
                Rectangle()
                    .fill(.thinMaterial)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Text(winLoseText)
                            .font(.system(size: 45))
                    }
                    .padding()
                    Button {
                        dismissClosure()
                    } label: {
                        Rectangle()
                            .frame(width: 500, height: 70)
                    }
                }
                .background(.red)
                .mask({
                    RoundedRectangle(cornerRadius: 12)
                })
            } else {

            }
        }
    }
}


struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ola")
            .modifier(PopupView(popupGameOver: .constant(true), winLoseText: "ganhou", dismissClosure: {
                print("Ganhou")
            }))

    }
}
