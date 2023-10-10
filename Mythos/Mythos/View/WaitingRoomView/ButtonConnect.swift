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
                .foregroundColor(.init(red: 255/255, green: 190/255, blue: 64/255))
            Text("Conectar")
                .foregroundColor(.init(red: 73/255, green: 40/255, blue: 16/255))
                .bold()
        }
    }
}

struct ButtonConnect_Previews: PreviewProvider {
    static var previews: some View {
        ButtonConnect()
    }
}
