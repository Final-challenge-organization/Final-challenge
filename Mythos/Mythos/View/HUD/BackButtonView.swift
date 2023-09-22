//
//  BackButtonView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 19/09/23.
//

import SwiftUI

struct BackButtonView: View {
    var body: some View {
        ZStack{
            Image(systemName: "chevron.backward")
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
        }
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView()
    }
}
