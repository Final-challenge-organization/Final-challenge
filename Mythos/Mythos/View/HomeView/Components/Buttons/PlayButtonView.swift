//
//  ButtonPlayView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 18/09/23.
//

import SwiftUI

struct PlayButtonView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
            Text("Iniciar batalha")
                .foregroundColor(.white)
        }
    }
}

struct ButtonPlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView()
    }
}
