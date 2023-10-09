//
//  PlayerView.swift
//  Mythos
//
//  Created by Ana Caroline Sampaio Nogueira on 09/10/23.
//

import Foundation

import SwiftUI

struct PlayerView: View {
    var playersImage: String
    var body: some View {
        Image(playersImage)
            .resizable()
            .frame(width: 60,height: 60)

//        ZStack{
//            VStack {
//                Image(playersImage.randomElement() ?? "")
//                    .resizable()
//                    .frame(width: 60,height: 60)
//                    .rotationEffect(.degrees(90))
//                    .padding(30)
//                    Spacer()
//                Image(playersImage.randomElement() ?? "")
//                    .resizable()
//                    .frame(width: 60,height: 60)
//                    .rotationEffect(.degrees(90))
//                    .padding(30)
//            }
//            HStack {
//                Image(playersImage.randomElement() ?? "")
//                    .resizable()
//                    .frame(width: 60,height: 60)
//                    .rotationEffect(.degrees(90))
//                    .padding(90)
//                Spacer()
//                Image(playersImage.randomElement() ?? "")
//                    .resizable()
//                    .frame(width: 60,height: 60)
//                    .rotationEffect(.degrees(90))
//                    .padding(90)
//            }
//        }
    }
}
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(playersImage: "sara")
    }
}
