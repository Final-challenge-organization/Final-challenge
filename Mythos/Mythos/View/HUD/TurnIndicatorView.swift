//
//  TurnIndicatorView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 09/11/23.
//

import SwiftUI

struct TurnIndicatorView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.init(red: 229/255, green: 187/255, blue: 32/255))
                .frame(width: 160, height: 50, alignment: .center)
                .blur(radius: 8)
            Text("Sua vez!!")
                .font(MyCustomFonts.CeasarDressingRegular.font)
                .frame(height: 35)
                .scaledToFit()
                .foregroundColor(Color.init(red: 60/255, green: 25/255, blue: 1/255))
                .animation(.easeInOut(duration: 1))
        }
    }
}

struct TurnIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        TurnIndicatorView()
    }
}
