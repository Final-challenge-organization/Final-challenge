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
        CardRepresentable(card: card, onTap: {
            withAnimation {
                killDecktapped.toggle()
            }
        })
        .rotationEffect(killDecktapped ? Angle(degrees: 0) : Angle(degrees: 90))
    }
}
