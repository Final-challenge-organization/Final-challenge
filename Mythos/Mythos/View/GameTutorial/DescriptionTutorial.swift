//
//  DescriptionTutorial.swift
//  Mythos
//
//  Created by Narely Lima on 13/11/23.
//

import SwiftUI

struct DescriptionTutorial: View {

    var description: String
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image(systemName: "bubble.left.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width)
                    .foregroundColor(Color.init(red: 229/255, green: 187/255, blue: 32/255))
                Text(description)
                    .italic()
                    .multilineTextAlignment(.center)
                    .frame(width: proxy.size.width/1.5)
                    .offset(y: -20)
                    .foregroundColor(Color.init(red: 60/255, green: 25/255, blue: 1/255))
            }

        }
    }
}

struct DescriptionTutorial_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionTutorial(description: "Tebjbbibiubibibibibibibibcfxxrxrxrxrxrxrxrxrxrxrxrxrxrxrxrxrxrxrxrxrxrxribibibste")
    }
}
