//
//  TutorialDescription.swift
//  Mythos
//
//  Created by Narely Lima on 28/11/23.
//

import SwiftUI

struct TutorialDescription: View {
    let stepDescription: String
    var body: some View {
            Text(stepDescription)
                .font(MyCustomFonts.CeasarDressingSmall.font)
                .scaledToFit()
                .foregroundColor(Color.init(red: 60/255, green: 25/255, blue: 1/255))
                .animation(.easeInOut(duration: 1.0))
                .padding(.horizontal, 20)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.init(red: 229/255, green: 187/255, blue: 32/255))
                        .blur(radius: 8)
                        .minimumScaleFactor(20)
                }
        }
}

struct TutorialDescription_Previews: PreviewProvider {
    static var previews: some View {
        TutorialDescription(stepDescription: "")
    }
}
