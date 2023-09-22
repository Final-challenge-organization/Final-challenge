//
//  WaitingRoomView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 18/09/23.
//

import SwiftUI

var players: [String] = ["player1", "player2", "player3"]
//var code: String = "12345"

struct WaitingRoomView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Esperando jogadores")
                Button(action: {}, label: {
                    Image(systemName: "doc.on.doc")
                })
                Spacer()
            }
            Spacer()
            HStack(spacing: 90) {
                ForEach(players, id: \.self) { item in
                    ConnectedPlayersView()
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal,content: {CustomToolbarView()})
        }
    }
}

struct WaitingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingRoomView().previewInterfaceOrientation(.landscapeLeft)
    }
}
