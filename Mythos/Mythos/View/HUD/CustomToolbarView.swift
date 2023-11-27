//
//  ToolbarView.swift
//  Mythos
//
//  Created by Cicero Nascimento on 21/09/23.
//

import SwiftUI

struct CustomToolbarView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
            HStack(alignment: .center, spacing: 44) {
                Button(action: {dismiss()},
                       label: {BackButtonView().frame(width: 23, height: 23)})
                Spacer()
                ZStack{

                    Text("Sala de espera")
                        .tracking(3)
                        .font(MyCustomFonts.CeasarDressingRegular.font)
//                        .foregroundColor(.black)
                }
                Spacer()
                ConfigButtonView()
                    .foregroundColor(.gray)
                    .frame(width: 46, height: 46)
            }
            .padding(.top,30)
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomToolbarView().previewInterfaceOrientation(.landscapeLeft)
    }
}
