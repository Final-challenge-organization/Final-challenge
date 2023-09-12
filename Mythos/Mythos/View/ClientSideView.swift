//
//  ClientSideView.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 05/09/23.
//

import SwiftUI

struct ClientSideView: View {

    @ObservedObject var webSocket = WebSocket()

    var body: some View {
        HStack {
            Image(webSocket.deck?[0].name ?? "Floresta Mortal")
                .resizable()
                .onTapGesture {
                    let card = webSocket.deck?[0]
                    var dataWrapper = DataWrapper(contentType: .card, content: Data())
                    dataWrapper.encodeContent(card)
                    webSocket.sendData(dataWrapper)
                }
            Image(webSocket.deck?[1].name ?? "Floresta Mortal")
                .resizable()
            Image(webSocket.deck?[2].name ?? "Floresta Mortal")
                .resizable()
            Text("Quanto de vida eu tenho?")
        }
    }
}

struct ClientSideView_Previews: PreviewProvider {
    static var previews: some View {
        ClientSideView()
    }
}
