//
//  StoreButtonView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 18/09/23.
//

import SwiftUI

struct StoreButtonView: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.gray)
            Text("💸")
                .foregroundColor(.white)
        }
    }
}

struct StoreButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StoreButtonView()
    }
}
