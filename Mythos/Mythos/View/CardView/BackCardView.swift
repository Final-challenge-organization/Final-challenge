//
//  BackCardView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 17/10/23.
//

import SwiftUI

struct BackCardView: View {
    var body: some View {
        Image("verso_carta")
            .resizable()
            .scaledToFit()
    }
}

struct BackCardView_Previews: PreviewProvider {
    static var previews: some View {
        BackCardView()
    }
}
