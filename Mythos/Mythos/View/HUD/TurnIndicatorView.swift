//
//  TurnIndicatorView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 09/11/23.
//

import SwiftUI

struct TurnIndicatorView: View {

    let turnDesc: String
    let showName: Bool

    var body: some View {
            Text(turnDesc)
                .font(MyCustomFonts.CeasarDressingRegular.font)
                .frame(height: 35)
                .scaledToFit()
                .foregroundColor(Color.init(red: 60/255, green: 25/255, blue: 1/255))
                .animation(.easeInOut(duration: 0.5))
                .padding(.horizontal, 20)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(showName ? Color.init(red: 229/255, green: 187/255, blue: 32/255) : .clear)
                        .blur(radius: 8)
                        .minimumScaleFactor(20)
                }

        }

}

struct TurnIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        TurnIndicatorView(turnDesc: "", showName: false)
    }
}
