//
//  ConnectedPlayersView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 21/09/23.
//

import SwiftUI

struct ConnectedPlayersView: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 115, height: 113)
                .foregroundColor(.gray)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 115, height: 26)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ConnectedPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectedPlayersView().previewLayout(.device)
    }
}
