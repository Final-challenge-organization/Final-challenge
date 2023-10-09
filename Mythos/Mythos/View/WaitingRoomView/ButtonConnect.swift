//
//  ButtonConnect.swift
//  Mythos
//
//  Created by Cicero Nascimento on 09/10/23.
//

import SwiftUI

struct ButtonConnect: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 90, height: 40)
                .scaledToFit()
                .foregroundColor(.gray)
            Text("Conectar")
                .foregroundColor(.white)
        }
    }
}

struct ButtonConnect_Previews: PreviewProvider {
    static var previews: some View {
        ButtonConnect()
    }
}
