//
//  ConnectedPlayersView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 21/09/23.
//

import SwiftUI

struct ConnectedPlayersView: View {
    var name: String
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 115, height: 113)
                .foregroundColor(.gray)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 115, height: 26)
                    .foregroundColor(.gray)
                Text(name)
                    .foregroundColor(.white)
            }
        }
    }
}
//
//struct ConnectedPlayersView_Previews: PreviewProvider {
//    static var previews: some View {
//        var indice = 1
//        ConnectedPlayersView(indice: 1).previewLayout(.device)
//    }
//}
