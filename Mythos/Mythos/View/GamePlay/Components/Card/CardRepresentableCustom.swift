//
//  CardRepresentableCustom.swift
//  Mythos
//
//  Created by Narely Lima on 29/11/23.
//

import SwiftUI

struct CardRepresentableCustom: View {
    
    let imageName: String
    let card: Card

    var body: some View {
        GeometryReader { geo in
            Image(imageName)
                .resizable()
                .overlay {
                    ZStack {
                        VStack {
                            Text(card.name)
                                .font(MyCustomFonts.CeasarDressingRegular.font)
                                .foregroundColor(Color("cardTitleColor"))
                                .minimumScaleFactor(0.01)
                                .lineLimit(0)
                                .padding([.leading, .trailing], geo.size.width/8)
                                .padding(.top, geo.size.height/40)
                                Spacer()
                        }
                        VStack {
                            Image(card.imageName)
                                .resizable()
                                .frame(width: geo.size.width/1.5, height:  geo.size.width/1.5)
                                .scaledToFit()
                                .padding(.bottom, geo.size.height/3.5)
                        }
                        VStack(spacing: 0) {
                            Spacer()
                            Text(card.effect)
                                .font(MyCustomFonts.CabinBold.font)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.01)
                                .foregroundColor(.white)
                                .lineLimit(2)
                                .padding([.leading, .trailing], geo.size.width/8)
                                .frame(width: geo.size.width, height: geo.size.height/10)
                            Text(card.description)
                                .font(MyCustomFonts.CabinMediumItalic.font)
                                .minimumScaleFactor(0.01)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("cardDescriptionColor"))
                                .padding([.leading, .trailing])
                                .frame(width: geo.size.width, height: geo.size.height/6.2)
                                .padding(.bottom, geo.size.height/14)
                        }
                    }
                }
        }
    }
}

struct CardRepresentableCustom_Previews: PreviewProvider {
    static var previews: some View {
        CardRepresentableCustom(imageName: "", card: Card(id: 0, name: "", imageName: "", type: .reaction, damage: 0, effect: "", description: ""))
    }
}
