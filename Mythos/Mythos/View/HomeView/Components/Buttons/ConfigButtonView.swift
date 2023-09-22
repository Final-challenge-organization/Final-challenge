//
//  ConfigView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 18/09/23.
//

import SwiftUI

struct ConfigButtonView: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.gray)
            Text("⚙️")

        }
    }
}

struct ConfigButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigButtonView()
    }
}
