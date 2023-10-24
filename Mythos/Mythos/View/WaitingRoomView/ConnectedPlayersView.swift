//
//  ConnectedPlayersView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 21/09/23.
//

import SwiftUI

struct ConnectedPlayersView: View {
    let name: String
    var body: some View {
        VStack {
            Image("backgroundButtonPlayer")
                .resizable()
                .scaledToFit()
                .frame(width: 115, height: 113)
                .foregroundColor(.gray)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 115, height: 26)
                    .foregroundColor(.init(red: 73/255, green: 40/255, blue: 16/255))
                Text(name)
                    .frame(maxWidth: 115)
                    .scaledToFit()
                    .foregroundColor(.white)
            }
        }
    }
}

struct ConnectedPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        let nameMock = "Teste"
        ConnectedPlayersView(name: nameMock).previewLayout(.device)
    }
}
