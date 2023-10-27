//
//  ButtonRoomView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 18/09/23.
//

import SwiftUI

struct InventoryButtonView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
            Text("Inventário")
                .foregroundColor(.white)
        }
    }
}

struct ButtonRoomView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryButtonView()
    }
}
